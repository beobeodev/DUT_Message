import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  FriendController friendController;

  IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    try {
      final String id = localRepository.getCurrentUser()["_id"];
      socket = IO.io("http://localhost:3000",
        IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .enableAutoConnect()  // enable auto-connection
        .setQuery({'userId': id})
        .build(),
      );
      socket.onConnect((_) {
        print('HAVE CONNECTED to socket');
        onAddFriend();
        onNotifyAcceptAddFriendRequest();
        onReceiveConversationMessage();
      });
    } catch (e) {
      print("Error in SocketUtil._init() $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
    friendController = Get.put(FriendController());
  }
  
  void emitAddFriend(String toId) {
    try {
      final String fromId = localRepository.getCurrentUser()["_id"];
      print("From emitAddFriend(): current id is $fromId");
      socket.emit(SocketEvent.sendAddFriendRequest, {
        "fromId": fromId,
        "toId": toId,
      });
      print(toId);
    } catch (e) {
      print("Error in emitAddFriend() from SocketUtil $e");
    }
  }

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
          avatar: data["from"]["avatar"],
        );
        print(friendRequest);
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

  void emitSendConversationMessage(String conversationId, String fromId, String toId, String content) {
    try {
      socket.emit(SocketEvent.sendConversationMessage, {
        "converId": conversationId,
        "fromUserId": fromId,
        "toUserId": toId,
        "content": content,
      });
      print(content);
    } catch (e) {
      print("Error in emitSendConversationMessage() from SocketUtil $e");
    }
  }

  void onReceiveConversationMessage() {
    try {
      print("onReceiveConversationMessage() was called");
      socket.on(SocketEvent.receiveConversationMessage, (data) {
        print(data);
      });
    } catch (e) {
      print("Error in onReceiveConversationMessage() from SocketUtil $e");
    }
  }
}