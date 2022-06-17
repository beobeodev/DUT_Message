import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat.controller.dart';
import 'package:flutter_frontend/modules/chat/widgets/menu_chat/create_room_conversation_sheet.widget.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_frontend/widgets/rounded_alert_dialog.widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuChatController extends GetxController {
  final UserRepository userRepository;

  final ChatController chatController;
  final RootController rootController;
  final AuthController authController;
  final FriendController friendController;

  MenuChatController({
    required this.userRepository,
    required this.chatController,
    required this.rootController,
    required this.authController,
    required this.friendController,
  });

  ConversationModel get currentConversation =>
      chatController.currentConversation;
  bool get isRoomConversation => currentConversation.isRoom;
  UserModel get friendUser => chatController.friendUser;

  List<UserModel> friends = [];

  @override
  void onInit() {
    super.onInit();

    final List<String> userInConversationIds =
        currentConversation.userIns.map((e) => e.id).toList();

    friends = List.from(
      friendController.friends
          .where((friend) => !userInConversationIds.contains(friend.id)),
    );
  }

  // final RxList<UserModel> searchedFriends;
  // // List<Map<String, dynamic>> friends = <Map<String, dynamic>>[];
  // // final RxList<Map<String, dynamic>> searchedFriends =
  // //     <Map<String, dynamic>>[].obs;

  // late List<String> selectedFriendIds;
  // // final RxList<Map<String, dynamic>> listFilterFriend = <Map<String, dynamic>>[].obs;
  // // final RxList<bool> listCheckSelectedFriend = <bool>[].obs;
  // // final RxList<User> listSelectedFriend = <User>[].obs;

  // void onChangeTextFieldFind(String value) {
  //   searchedFriends.value = List.from(
  //     friends.where(
  //       (element) =>
  //           element['user'].name.toLowerCase().contains(value.toLowerCase()),
  //     ),
  //   );
  // }

  Future<void> openBottomSheet() async {
    await showModalBottomSheet(
      context: Get.context!,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreateRoomConversationSheet(
          friends: friends,
          createRoomConversation: createRoomConversation,
        );
      },
    );
  }

  // void onTapSelectFriend(UserModel selectedFriend) {
  //   final int index = friends
  //       .indexWhere((element) => element['user'].id == selectedFriend.id);
  //   final int indexInListSearch = searchedFriends
  //       .indexWhere((element) => element['user'].id == selectedFriend.id);
  //   friends[index] = <String, dynamic>{
  //     'user': friends[index]['user'],
  //     'beSelected': !friends[index]['beSelected'],
  //   };
  //   searchedFriends[indexInListSearch] = friends[index];
  //   if (friends[index]['beSelected']) {
  //     selectedFriendIds.add(selectedFriend.id);
  //   } else {
  //     selectedFriendIds.removeWhere((element) => element == selectedFriend.id);
  //   }
  // }

  Future<void> createRoomConversation(
    List<String> selectedFriendIds,
    String nameRoom,
  ) async {
    if (selectedFriendIds.length < 2) {
      await showWarningDialog();
    } else {
      emitSendCreateRoom(
        selectedFriendIds,
        nameRoom,
      );

      // Get.toNamed(GetRouter.chat, arguments: [index, true]);
    }
    // Get.offNamedUntil(GetRouter.home, ModalRoute.withName(GetRouter.drawer));
  }

  Future<void> showWarningDialog() async {
    final Timer timer = Timer(const Duration(milliseconds: 600), () {
      Get.back();
    });
    await showDialog(
      context: Get.context!,
      builder: (BuildContext builderContext) {
        return const RoundedAlertDialog(
          icon: FontAwesomeIcons.exclamationTriangle,
          content: 'Vui lòng chọn bạn để tạo nhóm chat!',
        );
      },
    ).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }

  void emitSendCreateRoom(List<String> selectedIds, String nameRoom) {
    try {
      rootController.socket.emit(SocketEvent.sendCreateRoom, {
        'authorId': authController.currentUser!.id,
        'nameAuthor': authController.currentUser!.name,
        'ids': selectedIds,
        'nameRoom': nameRoom,
      });
    } catch (e) {
      log('Error in emitSendCreateRoom() from MenuChatController: $e');
    }
  }

  // void onTapCancelButton() {
  //   findTextController.clear();
  //   friends = friends
  //       .map(
  //         (e) => {
  //           'user': e['user'],
  //           'beSelected': false,
  //         },
  //       )
  //       .toList();
  //   searchedFriends.value = friends;
  //   Get.back();
  // }
}
