import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
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
      });
      onAddFriend();
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
      socket.emit(SocketEvent.sendFriendRequest, {
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
      socket.on(SocketEvent.receiveFriendRequest, (data) {
        final FriendRequest friendRequest = FriendRequest(
          friendRequestId: data["_id"],
          fromId: data["from"]["_id"],
          toId: currentId,
          name: data["from"]["name"],
          avatar: data["from"]["avatar"],
        );
        print(friendRequest);
        if (!friendController.listFriendRequest.any((element) => element.fromId == friendRequest.fromId)) {
          friendController.listFriendRequest.add(friendRequest);
        }
      });
    } catch (e) {
      print("Error in onAddFriend() from SocketUtil $e");
    }
  }
}