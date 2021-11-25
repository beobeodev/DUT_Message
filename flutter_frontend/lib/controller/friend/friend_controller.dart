import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enum.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/widgets/custom/hero_popup_route.dart';
import 'package:flutter_frontend/widgets/friend/popup/popup_profile_friend.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  final UserRepository userRepository = UserRepository();

  final SocketController socketController = Get.put(SocketController());

  final TextEditingController phoneNumberEditingController = TextEditingController();

  final PageController pageController = PageController();

  final RxBool isOpenListTab = true.obs;
  final RxInt indexPage = 0.obs;
  final RxString errorPhoneNumber = "".obs;
  final RxList<FriendRequest> listFriendRequest = <FriendRequest>[].obs;

  void onTapListTab() {
    pageController.jumpToPage(0);
    isOpenListTab.value = true;
  }
  void onTapAddTab() {
    pageController.jumpToPage(1);
    isOpenListTab.value = false;
  }

  void onPageChange(int index) {
    isOpenListTab.value = !isOpenListTab.value;
    indexPage.value = index;
  }

  void onTapTextField() {
    errorPhoneNumber.value = "";
  }

  Future<void> onTapFindButton() async {
    errorPhoneNumber.value = "";
    if (phoneNumberEditingController.text == "") {
      errorPhoneNumber.value = "Vui lòng nhập số điện thoại cần tìm";
      return;
    } else if (phoneNumberEditingController.text.length != 10) {
      errorPhoneNumber.value = "Số điện thoại không hợp lệ";
      return ;
    } else {
      final CustomResponse response = await userRepository.getUserByPhoneNumber(phoneNumberEditingController.text);
      // check if user not exist with phone number need get
      if (response.error && response.statusCode == 404) {
        errorPhoneNumber.value = "Số điện thoại này chưa được đăng ký";
      } else if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = response.responseBody;
        final Map<String, dynamic> responseCheckAddFriendRequest = (await userRepository.checkAddFriendRequest(responseBody["_id"])).responseBody;

        AddFriendStatus addFriendStatus;

        if (responseCheckAddFriendRequest["message"] == "is friend") {
          addFriendStatus = AddFriendStatus.isFriend;
        } else if (responseCheckAddFriendRequest["message"] == "have send add friend request") {
          addFriendStatus = AddFriendStatus.haveSendAddFriendRequest;
        } else if (responseCheckAddFriendRequest["message"] == "have receive add friend request") {
          addFriendStatus = AddFriendStatus.haveReceiveAddFriendRequest;
        } else {
          addFriendStatus = AddFriendStatus.noAddFriendRequest;
        }

        Navigator.of(Get.context).push(
          HeroPopupRoute(
            builder: (context) => Center(
              child: PopUpProfileFriend(
                imageURL: responseBody["avatar"],
                name: responseBody["name"],
                id: responseBody["_id"], // id of user being find
                friendController: this,
                addFriendStatus: addFriendStatus,
              ),
            ),
          ),
        );
      }
    }
  }

  void onPressAddFriend(String id) {
    socketController.emitAddFriend(id);
    Get.back();
  }
}