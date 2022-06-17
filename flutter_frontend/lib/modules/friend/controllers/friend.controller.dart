import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/core/widgets/hero_popup_route.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/popup_profile_friend.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/core/constants/enums/add_friend_status.enum.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/friend_request.model.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';

class FriendController extends GetxController {
  final UserRepository userRepository;

  final HomeController homeController;
  final AuthController authController;
  final RootController rootController;

  FriendController({
    required this.userRepository,
    required this.homeController,
    required this.authController,
    required this.rootController,
  });

  final TextEditingController phoneTextController = TextEditingController();
  final RxString errorPhoneNumber = ''.obs;

  final PageController pageController = PageController();

  final RxInt currentTabIndex = 0.obs;

  final GlobalKey<FormState> formPhoneNumber = GlobalKey<FormState>();

  final RxList<FriendRequestModel> addFriendRequests =
      <FriendRequestModel>[].obs;
  final RxList<UserModel> friends = <UserModel>[].obs;
  final RxList<UserModel> filteredFriends = <UserModel>[].obs;

  Future<void> getData() async {
    try {
      friends.value = await userRepository.getFriends();
      filteredFriends.value = friends;
      addFriendRequests.value = await userRepository.getAddFriendRequests();

      listenChangeOfFriends();
      onReceiveAddFriendRequest();
      onNotifyAcceptAddFriendRequest();
      onRemoveFriendRequest();
      onReceiveCancelFriend();
    } on DioError catch (dioError) {
      log('Error in getData() from Friend Controller: ${dioError.response.toString()}');
    } catch (e) {
      log('Error in getData() from Friend Controller: ${e.toString()}');
      rethrow;
    }
  }

  void onReceiveAddFriendRequest() {
    try {
      final String currentUserId = authController.currentUser!.id;
      rootController.socket.on(SocketEvent.receiveAddFriendRequest, (data) {
        final FriendRequestModel friendRequest = FriendRequestModel(
          friendRequestId: data['_id'],
          fromId: data['from']['_id'],
          toId: currentUserId,
          name: data['from']['name'],
          avatar: data['from']['avatar'],
        );
        addFriendRequests.add(friendRequest);
      });
    } catch (e) {
      log('Error in onReceiveAddFriendRequest(): $e');
    }
  }

  void onNotifyAcceptAddFriendRequest() {
    try {
      rootController.socket.on(SocketEvent.notifyAcceptAddFriendRequest,
          (data) {
        final UserModel user = UserModel.fromJson(data['infoFriend']);
        final ConversationModel conversation =
            ConversationModel.fromJson(data['conver']);
        homeController.conversations.add(conversation);
        friends.add(user);
      });
    } catch (e) {
      log('Error in notifyAcceptAddFriendRequest() $e');
    }
  }

  void onRemoveFriendRequest() {
    try {
      rootController.socket.on(SocketEvent.removeFriendRequest, (data) {
        addFriendRequests
            .removeWhere((element) => element.friendRequestId == data['_id']);
      });
    } catch (e) {
      log('Error in onRemoveFriendRequest(): $e');
    }
  }

  void onReceiveCancelFriend() {
    try {
      rootController.socket.on(SocketEvent.receiveCancelFriend, (data) {
        friends.removeWhere((element) => element.id == data);
      });
    } catch (e) {
      log('Error in onReceiveCancelFriend() $e');
    }
  }

  void listenChangeOfFriends() {
    friends.listen((p0) {
      filteredFriends.value = p0;
    });
  }

  void onPressTab(int index) {
    currentTabIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    currentTabIndex.value = index;
  }

  void onTapPhoneField() {
    errorPhoneNumber.value = '';
  }

  String? validatePhoneNumber(String? value) {
    if (value == '') {
      return 'Vui lòng nhập số điện thoại cần tìm';
    } else if (value!.length != 10) {
      return 'Số điện thoại không hợp lệ';
    } else if (value == authController.currentUser!.phone) {
      return 'Đây là số điện thoại của bạn';
    }

    return null;
  }

  Future<void> onTapButtonFind() async {
    errorPhoneNumber.value = '';

    if (!formPhoneNumber.currentState!.validate()) {
      return;
    }

    try {
      final UserModel searchedUser =
          await userRepository.getUserByPhoneNumber(phoneTextController.text);

      await showPopup(searchedUser);
    } on DioError catch (dioError) {
      log('Error in onTapButtonFind() from Friend Controller: ${dioError.toString()}');

      if (dioError.response?.statusCode == 404) {
        errorPhoneNumber.value = 'Số điện thoại này chưa được đăng ký';
      }
    }
  }

  Future<void> showPopup(UserModel searchedUser) async {
    final Map<String, dynamic> responseCheckAddFriendRequest =
        await userRepository.checkAddFriendRequest(searchedUser.id);

    AddFriendStatus addFriendStatus;

    if (responseCheckAddFriendRequest['message'] == 'is friend') {
      addFriendStatus = AddFriendStatus.isFriend;
    } else if (responseCheckAddFriendRequest['message'] ==
        'have send add friend request') {
      addFriendStatus = AddFriendStatus.haveSendAddFriendRequest;
    } else if (responseCheckAddFriendRequest['message'] ==
        'have receive add friend request') {
      addFriendStatus = AddFriendStatus.haveReceiveAddFriendRequest;
    } else {
      addFriendStatus = AddFriendStatus.noAddFriendRequest;
    }

    Navigator.of(Get.context!).push(
      HeroPopupRoute(
        builder: (context) => Center(
          child: PopUpProfileFriend(
            infoFriend: searchedUser, // id of user being find
            addFriendStatus: addFriendStatus,
          ),
        ),
      ),
    );

    phoneTextController.clear();
  }

  void onTapButtonAddFriend(String friendId) {
    try {
      final String fromId = authController.currentUser!.id;

      rootController.socket.emit(SocketEvent.sendAddFriendRequest, {
        'fromId': fromId,
        'toId': friendId,
      });
    } catch (e) {
      log('Error in emitAddFriend(): $e');
    }

    Get.back();
  }

  void onTapButtonAcceptAddFriendRequest(String friendId) {
    try {
      rootController.socket.emit(SocketEvent.acceptAddFriendRequest, {
        'fromId': friendId,
        'toId': authController.currentUser!.id,
      });

      addFriendRequests.removeWhere((element) => element.fromId == friendId);
    } catch (e) {
      log('Error in onTapButtonAcceptAddFriendRequest(): $e');
    }
  }

  void onTapButtonRefuseAddFriendRequest(
    String friendRequestId,
    String friendId,
  ) {
    try {
      rootController.socket.emit(SocketEvent.cancelFriendRequest, {
        'friend_request_id': friendRequestId,
        'fromId': friendId,
        'toId': authController.currentUser!.id,
      });
    } catch (e) {
      log('Error in onTapButtonRefuseAddFriendRequest(): $e');
    }
  }

  void onTapButtonCancelFriend(String friendId) {
    Get.back();
    try {
      rootController.socket.emit(SocketEvent.sendCancelFriend, {
        'fromId': authController.currentUser!.id,
        'toId': friendId,
      });
    } catch (e) {
      log('Error in sendCancelFriend(): $e');
    }
  }

  void onChangeTextFieldFindFriend(String value) {
    filteredFriends.value = friends
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  void onTapFriendCard(int index) {
    // open popup about info of friend
    Navigator.of(Get.context!).push(
      HeroPopupRoute(
        builder: (context) => Center(
          child: PopUpProfileFriend(
            infoFriend: filteredFriends[index],
            addFriendStatus: AddFriendStatus.isFriend,
          ),
        ),
      ),
    );
  }

  void onPressButtonChat(String friendId) {
    Get.back();
    // final int indexConversation = homeController.listConversationAndRoom.indexWhere((element) => element.listUserIn.any((element) => element.id == friendId) && element.listUserIn.length == 2);
    Get.toNamed(
      RouteManager.chat,
      arguments: [
        homeController.conversations.firstWhere(
          (element) =>
              element.userIns.any((element) => element.id == friendId) &&
              element.userIns.length == 2,
        ),
        false
      ],
    );
  }
}
