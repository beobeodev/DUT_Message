// import 'package:get/get.dart';

// class SocketController extends GetxController {
  // // final HiveLocalRepository localRepository = HiveLocalRepository();
  // final UserRepository userRepository = UserRepository();
  // final AuthController authController = Get.find<AuthController>();

  // late FriendController friendController;
  // late HomeController homeController;

  // late io.Socket socket;

  // @override
  // void onInit() {
  //   try {
  //     final String id = authController.currentUser!.id;
  //     socket = io.io(
  //       dotenv.env['SOCKET_URL'],
  //       io.OptionBuilder()
  //           .setTransports(['websocket']) // for Flutter or Dart VM
  //           // .enableAutoConnect()
  //           // .enableReconnection()// enable auto-connection
  //           .setQuery({'userId': id}).build(),
  //     );
  //     socket.connect();
  //     socket.onConnect((_) {
  //       print('HAVE CONNECTED to socket');
  //       onAddFriend();
  //       onNotifyAcceptAddFriendRequest();
  
  //       onReceiveConversationMessage();
  //       onReceiveRoomMessage();
  //       onReceiveCreateRoom();
  //       // onReceiveJoinRoom();

  //       onReceiveRemoveConversationMessage();
  //       onReceiveRemoveRoomMessage();

  //       onReceiveCancelFriend();
  //       onRemoveFriendRequest();
  //     });
  //   } catch (e) {
  //     print('Error in SocketUtil._init() $e');
  //     rethrow;
  //   }
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  //   friendController = Get.put(FriendController());
  //   homeController =
  //       Get.put(HomeController(authController: Get.find<AuthController>()));
  // }

  // @override
  // void onClose() {
  //   print('DISPOSE SOCKET!');
  //   socket.onDisconnect((data) => print(data));
  //   socket.ondisconnect();
  //   socket.close();
  //   socket.dispose();
  //   super.onClose();
  // }

  // // this function to send add friend request
  // void emitAddFriend(String toId) {
  //   try {
  //     final String fromId = authController.currentUser!.id;
  //     print('From emitAddFriend(): current id is $fromId');
  //     socket.emit(SocketEvent.sendAddFriendRequest, {
  //       'fromId': fromId,
  //       'toId': toId,
  //     });
  //     // print(toId);
  //   } catch (e) {
  //     print('Error in emitAddFriend() from SocketUtil $e');
  //   }
  // }

  // // this function to handle event on add friend request
  // // (receive add friend request)
  // void onAddFriend() {
  //   try {
  //     final String currentId = authController.currentUser!.id;
  //     print('From onAddFriend(): current id is $currentId');
  //     socket.on(SocketEvent.receiveAddFriendRequest, (data) {
  //       final FriendRequest friendRequest = FriendRequest(
  //         friendRequestId: data['_id'],
  //         fromId: data['from']['_id'],
  //         toId: currentId,
  //         name: data['from']['name'],
  //         avatar: data['from']['avatar'] == ''
  //             ? 'https://www.zimlive.com/dating/wp-content/themes/gwangi/assets/images/avatars/user-avatar.png'
  //             : data['from']['avatar'],
  //       );
  //       friendController.addFriendRequests.add(friendRequest);
  //     });
  //   } catch (e) {
  //     print('Error in onAddFriend() from SocketUtil $e');
  //   }
  // }

  // // this function to send accept add friend request
  // void emitAcceptAddFriendRequest(String fromId) {
  //   try {
  //     socket.emit(SocketEvent.acceptAddFriendRequest, {
  //       'fromId': fromId,
  //       'toId': authController.currentUser!.id,
  //     });
  //     friendController.addFriendRequests
  //         .removeWhere((element) => element.fromId == fromId);
  //   } catch (e) {
  //     print('Error in onAcceptAddFriendRequest() from SocketUtil $e');
  //   }
  // }

  // // this function to listen accept add friend request
  // // ex: have someone accept your add friend request
  // void onNotifyAcceptAddFriendRequest() {
  //   try {
  //     socket.on(SocketEvent.notifyAcceptAddFriendRequest, (data) {
  //       print(data);
  //       final User user = User.fromJson(data['infoFriend']);
  //       final ConversationModel conversation =
  //           ConversationModel.fromJson(data['conver']);
  //       homeController.conversations.add(conversation);
  //       friendController.friends.add(user);
  //     });
  //   } catch (e) {
  //     print('Error in notifyAcceptAddFriendRequest() from SocketUtil $e');
  //   }
  // }

  // // this function to emit event UNFRIEND
  // void sendCancelFriend(String toId) {
  //   try {
  //     socket.emit(SocketEvent.sendCancelFriend, {
  //       'fromId': authController.currentUser!.id,
  //       'toId': toId,
  //     });
  //   } catch (e) {
  //     print('Error in sendCancelFriend() from SocketUtil $e');
  //   }
  // }

  // void onReceiveCancelFriend() {
  //   try {
  //     socket.on(SocketEvent.receiveCancelFriend, (data) {
  //       friendController.friends.removeWhere((element) => element.id == data);
  //     });
  //   } catch (e) {
  //     print('Error in onReceiveCancelFriend() from SocketUtil $e');
  //   }
  // }

  // // this function to handle event refuse add friend request
  // void emitRemoveFriendRequest(String friendRequestId, String fromId) {
  //   try {
  //     socket.emit(SocketEvent.cancelFriendRequest, {
  //       'friend_request_id': friendRequestId,
  //       'fromId': fromId,
  //       'toId': authController.currentUser!.id,
  //     });
  //   } catch (e) {
  //     print('Error in emitRemoveFriendRequest() from SocketController $e');
  //   }
  // }

  // void onRemoveFriendRequest() {
  //   try {
  //     socket.on(SocketEvent.removeFriendRequest, (data) {
  //       friendController.addFriendRequests
  //           .removeWhere((element) => element.friendRequestId == data['_id']);
  //     });
  //   } catch (e) {
  //     print('Error in onRemoveFriendRequest() from SocketController $e');
  //   }
  // }

  // // ---- SOCKET FOR CHAT ONE TO ONE ----- //

  // void emitSendConversationMessage({
  //   required String conversationId,
  //   required String fromId,
  //   required String toId,
  //   required String content,
  //   bool isImg = false,
  // }) {
  //   try {
  //     final String encryptContent = EncryptMessage.encryptAES(content);

  //     socket.emit(SocketEvent.sendConversationMessage, {
  //       'converId': conversationId,
  //       'fromUserId': fromId,
  //       'toUserId': toId,
  //       'content': encryptContent,
  //       'isImg': isImg,
  //     });
  //     // final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == conversationId);
  //     // final Conversation conversationTemp = homeController.listConversationAndRoom[index];
  //     // conversationTemp.listMessage.add(Message(
  //     //   author: localRepository.infoCurrentUser,
  //     //   content: content,
  //     //   timeSend: DateTime.now(),
  //     //   isImage: isImg,
  //     // ),);
  //     // homeController.listConversationAndRoom[index] = conversationTemp;
  //     // print(content);
  //   } catch (e) {
  //     print('Error in emitSendConversationMessage() from SocketUtil $e');
  //   }
  // }

  // void onReceiveConversationMessage() {
  //   try {
  //     print('onReceiveConversationMessage() was called');
  //     socket.on(SocketEvent.receiveConversationMessage, (data) {
  //       final int index = homeController.conversations
  //           .indexWhere((element) => element.id == data['converId']);
  //       final ConversationModel conversationTemp =
  //           homeController.conversations[index];
  //       conversationTemp.listMessage.add(Message.fromMap(data['message']));
  //       final List<ConversationModel> listTemp =
  //           List.from(homeController.conversations);
  //       listTemp.removeWhere((element) => element.id == data['converId']);
  //       homeController.conversations.value = [conversationTemp, ...listTemp];
  //     });
  //   } catch (e) {
  //     print('Error in onReceiveConversationMessage() from SocketUtil $e');
  //   }
  // }

  // // this function to emit event delete room message
  // void sendRemoveConverMessage(String messageId, String toId, String converId) {
  //   try {
  //     socket.emit(SocketEvent.sendRemoveConversationMessage, {
  //       'messageId': messageId,
  //       'fromId': authController.currentUser!.id,
  //       'toId': toId,
  //       'converId': converId,
  //     });
  //   } catch (e) {
  //     print('Error in sendRemoveConversationMessage() from SocketUtil $e');
  //   }
  // }

  // void onReceiveRemoveConversationMessage() {
  //   try {
  //     socket.on(SocketEvent.receiveRemoveConversationMessage, (data) {
  //       // get current conversation and remove message
  //       final ConversationModel conversationTemp = homeController.conversations
  //           .firstWhere((element) => element.id == data['converId']);
  //       final Message messageTemp = conversationTemp.listMessage
  //           .firstWhere((element) => element.id == data['messageId']);
  //       messageTemp.isDeleted = true;
  //       // get list which haven't current conversation
  //       final List<ConversationModel> listTemp =
  //           List.from(homeController.conversations);
  //       listTemp.removeWhere((element) => element.id == data['converId']);
  //       // push current conversation to position 0 of list conversation
  //       homeController.conversations.value = [conversationTemp, ...listTemp];
  //     });
  //   } catch (e) {
  //     print('Error in onReceiveRemoveConversationMessage() from SocketUtil $e');
  //   }
  // }
  // // ---- END SOCKET CHAT ONE TO ONE ---- //

  // // ----- SOCKET FOR CHAT ROOM ----- //
  // void emitSendCreateRoom(List<String> listId, String nameRoom) {
  //   try {
  //     socket.emit(SocketEvent.sendCreateRoom, {
  //       'authorId': authController.currentUser!.id,
  //       'nameAuthor': authController.currentUser!.name,
  //       'ids': listId,
  //       'nameRoom': nameRoom,
  //     });
  //   } catch (e) {
  //     print('Error in emitSendCreateRoom() from SocketController: $e');
  //   }
  // }

  // void onReceiveCreateRoom() {
  //   try {
  //     socket.on(SocketEvent.receiveCreateRoom, (data) {
  //       socket.emit(SocketEvent.sendJoinRoom, {
  //         'fromId': authController.currentUser!.id,
  //         'roomId': data['_id'],
  //       });
  //       final ConversationModel roomChat = ConversationModel.fromJsonRoom(data);
  //       homeController.conversations.value = [
  //         roomChat,
  //         ...homeController.conversations
  //       ];
  //       Get.offNamedUntil(
  //         RouteManager.chat,
  //         ModalRoute.withName(RouteManager.drawer),
  //         arguments: [
  //           homeController.conversations
  //               .firstWhere((element) => element.id == roomChat.id),
  //           true
  //         ],
  //       );
  //     });
  //   } catch (e) {
  //     print('Error in onReceiveCreateRoom() from SocketController: $e');
  //   }
  // }

  // // void onReceiveJoinRoom() {
  // //   try {
  // //     socket.on(SocketEvent.receiveJoinRoom, (data) {
  // //       print(data);
  // //       final Conversation roomChat = Conversation.fromMapRoom(data);
  // //       homeController.listConversationAndRoom.add(roomChat);
  // //       print(homeController.listConversationAndRoom.length);
  // //       final ConversationRepository conversationRepository = ConversationRepository();
  // //       print(conversationRepository.listConversationAndRoom.length);
  // //     });
  // //   } catch (e) {
  // //     print("Error in onReceiveJoinRoom() from SocketController: $e");
  // //   }
  // // }

  // void emitSendRoomMessage({
  //   required String roomId,
  //   required String content,
  //   bool isImg = false,
  // }) {
  //   try {
  //     final String encryptContent = EncryptMessage.encryptAES(content);

  //     socket.emit(SocketEvent.sendRoomMessage, {
  //       'roomId': roomId,
  //       'content': encryptContent,
  //       'fromUserId': authController.currentUser!.id,
  //       'isImg': isImg,
  //     });
  //     // final int index = homeController.listConversationAndRoom.indexWhere((element) => element.id == roomId);
  //     // final Conversation conversationTemp = homeController.listConversationAndRoom[index];
  //     // conversationTemp.listMessage.add(Message(
  //     //   author: localRepository.infoCurrentUser,
  //     //   content: content,
  //     //   timeSend: DateTime.now(),
  //     //   isImage: isImg,
  //     // ),);
  //     // homeController.listConversationAndRoom[index] = conversationTemp;
  //   } catch (e) {
  //     print('ERROR in emitSendRoomMessage() from SocketController: $e');
  //   }
  // }

  // void onReceiveRoomMessage() {
  //   try {
  //     socket.on(SocketEvent.receiveRoomMessage, (data) {
  //       final int index = homeController.conversations
  //           .indexWhere((element) => element.id == data['roomId']);
  //       // get current conversation and add message to it
  //       final ConversationModel conversationTemp =
  //           homeController.conversations[index];
  //       conversationTemp.listMessage.add(Message.fromMap(data['message']));
  //       // get list which haven't current conversation
  //       final List<ConversationModel> listTemp =
  //           List.from(homeController.conversations);
  //       listTemp.removeWhere((element) => element.id == data['roomId']);
  //       // push current conversation to position 0 of list conversation
  //       homeController.conversations.value = [conversationTemp, ...listTemp];
  //     });
  //   } catch (e) {
  //     print('ERROR in onReceiveRoomMessage() from SocketController: $e');
  //   }
  // }

  // // this function to emit event delete room message
  // void sendRemoveRoomMessage(String roomId, String messageId) {
  //   try {
  //     socket.emit(SocketEvent.sendRemoveRoomMessage, {
  //       'roomId': roomId,
  //       'messageId': messageId,
  //     });
  //   } catch (e) {
  //     print('Error in sendRemoveConversationMessage() from SocketUtil $e');
  //   }
  // }

  // void onReceiveRemoveRoomMessage() {
  //   try {
  //     socket.on(SocketEvent.receiveRemoveRoomMessage, (data) {
  //       // get current conversation and remove message
  //       final ConversationModel conversationTemp =
  //           homeController.conversations.firstWhere(
  //         (element) => element.id == data['roomId'],
  //       );
  //       final Message messageTemp = conversationTemp.listMessage.firstWhere(
  //         (
  //           element,
  //         ) =>
  //             element.id == data['messageId'],
  //       );
  //       messageTemp.isDeleted = true;
  //       // get list which haven't current conversation
  //       final List<ConversationModel> listTemp = List.from(
  //         homeController.conversations,
  //       );
  //       listTemp.removeWhere((element) => element.id == data['roomId']);
  //       // push current conversation to position 0 of list conversation
  //       homeController.conversations.value = [conversationTemp, ...listTemp];
  //     });
  //   } catch (e) {
  //     print('Error in onReceiveRemoveConversationMessage() from SocketUtil $e');
  //   }
  // }

  // // ---- END SOCKET FOR CHAT ROOM ---- //
// }
