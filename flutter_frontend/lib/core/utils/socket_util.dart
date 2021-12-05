import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/conversation_repository.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final UserRepository userRepository = UserRepository();

  FriendController friendController;
  HomeController homeController;

  IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    print("init SocketController");
    try {
      final String id = localRepository.getCurrentUser()["_id"];
      socket = IO.io("http://localhost:3000",
        IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        // .enableAutoConnect()
        // .enableReconnection()// enable auto-connection
        .setQuery({'userId': id})
        .build(),
      );
      socket.connect();
      socket.onConnect((_) {
        print('HAVE CONNECTED to socket');
        onAddFriend();
        onNotifyAcceptAddFriendRequest();
        onReceiveConversationMessage();
        onReceiveCreateRoom();
        // onReceiveJoinRoom();
        onReceiveRoomMessage();
      });
    } catch (e) {
      print("Error in SocketUtil._init() $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
    friendController = Get.put(FriendController());
    homeController = Get.put(HomeController());
  }

  @override
  void onClose() {
    print("DISPOSE SOCKET!");
    socket.onDisconnect((data) => print(data));
    socket.ondisconnect();
    socket.close();
    socket.dispose();
    super.onClose();
  }
  
  void emitAddFriend(String toId) {
    try {
      final String fromId = localRepository.getCurrentUser()["_id"];
      print("From emitAddFriend(): current id is $fromId");
      socket.emit(SocketEvent.sendAddFriendRequest, {
        "fromId": fromId,
        "toId": toId,
      });
      // print(toId);
    } catch (e) {
      print("Error in emitAddFriend() from SocketUtil $e");
    }
  }

  // this function to handle event on add friend
  // (receive add friend request)
  void onAddFriend() {
    try {
      final String currentId = localRepository.getCurrentUser()["_id"];
      print("From onAddFriend(): current id is $currentId");
      socket.on(SocketEvent.receiveAddFriendRequest, (data) {
        final FriendRequest friendRequest = FriendRequest(
          friendRequestId: data["_id"],
          fromId: data["from"]["_id"],
          toId: currentId,
          name: data["from"]["name"],
          avatar: data["from"]["avatar"] == "" ? "https://www.zimlive.com/dating/wp-content/themes/gwangi/assets/images/avatars/user-avatar.png" : data["from"]["avatar"],
        );
        friendController.listAddFriendRequest.add(friendRequest);
      });
    } catch (e) {
      print("Error in onAddFriend() from SocketUtil $e");
    }
  }

  void emitAcceptAddFriendRequest(String fromId, String toId) {
    try {
      socket.emit(SocketEvent.acceptAddFriendRequest, {
        "fromId": fromId,
        "toId": toId,
      });
      friendController.listAddFriendRequest.removeWhere((element) => element.fromId == fromId);
    } catch (e) {
      print("Error in onAcceptAddFriendRequest() from SocketUtil $e");
    }
  }

  void onNotifyAcceptAddFriendRequest() {
    try {
      socket.on(SocketEvent.notifyAcceptAddFriendRequest, (data) {
        final User user = User.fromMap(data);
        friendController.listFriend.add(user);
      });
    } catch (e) {
      print("Error in notifyAcceptAddFriendRequest() from SocketUtil $e");
    }
  }

  void emitSendConversationMessage({String conversationId, String fromId, String toId, String content, bool isImg = false}) {
    try {
      socket.emit(SocketEvent.sendConversationMessage, {
        "converId": conversationId,
        "fromUserId": fromId,
        "toUserId": toId,
        "content": content,
        "isImg": isImg,
      });
      // final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == conversationId);
      // final Conversation conversationTemp = homeController.listConversationAndRoom[index];
      // conversationTemp.listMessage.add(Message(
      //   author: localRepository.infoCurrentUser,
      //   content: content,
      //   timeSend: DateTime.now(),
      //   isImage: isImg,
      // ),);
      // homeController.listConversationAndRoom[index] = conversationTemp;
      // print(content);
    } catch (e) {
      print("Error in emitSendConversationMessage() from SocketUtil $e");
    }
  }

  void onReceiveConversationMessage() {
    try {
      // print("onReceiveConversationMessage() was called");
      socket.on(SocketEvent.receiveConversationMessage, (data) {
        final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == data["converId"]);
        final Conversation conversationTemp = homeController.listConversationAndRoom[index];
        conversationTemp.listMessage.add(Message.fromMap(data["message"]));
        final List<Conversation> listTemp =  List.from(homeController.listConversationAndRoom);
        listTemp.removeWhere((element) => element.id == data["converId"]);
        homeController.listConversationAndRoom.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      print("Error in onReceiveConversationMessage() from SocketUtil $e");
    }
  }

  // ----- SOCKET FOR CHAT ROOM ----- //
  void emitSendCreateRoom(List<String> listId, String nameRoom) {
    try {
      socket.emit(SocketEvent.sendCreateRoom, {
        "authorId": localRepository.infoCurrentUser.id,
        "nameAuthor": localRepository.infoCurrentUser.name,
        "ids": listId,
        "nameRoom": nameRoom,
      });
    } catch (e) {
      print("Error in emitSendCreateRoom() from SocketController: $e");
    }
  }

  void onReceiveCreateRoom() {
    try {
      socket.on(SocketEvent.receiveCreateRoom, (data) {
        socket.emit(SocketEvent.sendJoinRoom, {
          "fromId": localRepository.infoCurrentUser.id,
          "roomId": data["_id"],
        });
        final Conversation roomChat = Conversation.fromMapRoom(data);
        homeController.listConversationAndRoom.value = [roomChat, ...homeController.listConversationAndRoom];
        final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == roomChat.id);
        Get.offNamedUntil(GetRouter.chat, ModalRoute.withName(GetRouter.drawer), arguments: [index, true]);
      });
    } catch (e) {
      print("Error in onReceiveCreateRoom() from SocketController: $e");
    }
  }

  // void onReceiveJoinRoom() {
  //   try {
  //     socket.on(SocketEvent.receiveJoinRoom, (data) {
  //       print(data);
  //       final Conversation roomChat = Conversation.fromMapRoom(data);
  //       homeController.listConversationAndRoom.add(roomChat);
  //       print(homeController.listConversationAndRoom.length);
  //       final ConversationRepository conversationRepository = ConversationRepository();
  //       print(conversationRepository.listConversationAndRoom.length);
  //     });
  //   } catch (e) {
  //     print("Error in onReceiveJoinRoom() from SocketController: $e");
  //   }
  // }

  void emitSendRoomMessage({@required String roomId, @required  String content, bool isImg = false}) {
    try {
      socket.emit(SocketEvent.sendRoomMessage, {
        "roomId": roomId,
        "content": content,
        "fromUserId": localRepository.infoCurrentUser.id,
        "isImg": isImg,
      });
      // final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == roomId);
      // final Conversation conversationTemp = homeController.listConversationAndRoom[index];
      // conversationTemp.listMessage.add(Message(
      //   author: localRepository.infoCurrentUser,
      //   content: content,
      //   timeSend: DateTime.now(),
      //   isImage: isImg,
      // ),);
      // homeController.listConversationAndRoom[index] = conversationTemp;
    } catch (e) {
      print("ERROR in emitSendRoomMessage() from SocketController: $e");
    }
  }

  void onReceiveRoomMessage() {
    try {
      socket.on(SocketEvent.receiveRoomMessage, (data) {
        final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == data["roomId"]);
        final Conversation conversationTemp = homeController.listConversationAndRoom[index];
        conversationTemp.listMessage.add(Message.fromMap(data["message"]));
        final List<Conversation> listTemp =  List.from(homeController.listConversationAndRoom);
        listTemp.removeWhere((element) => element.id == data["roomId"]);
        homeController.listConversationAndRoom.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      print("ERROR in onReceiveRoomMessage() from SocketController: $e");
    }
  }

  // ---- END SOCKET FOR CHAT ROOM ---- //
}