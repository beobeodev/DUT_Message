import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enum.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
import 'package:flutter_frontend/data/models/user.dart';
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
  // this variable to check error when user find user by phone number
  final RxString errorPhoneNumber = "".obs;
  // This variable to store list add friend request
  final RxList<FriendRequest> listAddFriendRequest = <FriendRequest>[].obs;
  // this variable to store list friend of current user
  final RxList<User> listFriend = <User>[].obs;
  final RxList<User> listFriendFilter = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    listFriend.value = userRepository.listFriend;
    listFriendFilter.value = listFriend;
    listAddFriendRequest.value = userRepository.listAddFriendRequest;
  }

  @override
  void onReady() {
    super.onReady();
    // getListAddFriendRequest();
    // getListFriend();
    listenChangeOfListFriend();
  }

  // Future<void> getListAddFriendRequest() async {
  //   final List<FriendRequest> result = (await userRepository.getListAddFriendRequest()).responseBody["result"];
  //   listAddFriendRequest.value = result;
  // }
  //
  // Future<void> getListFriend() async {
  //   listFriend.value = (await userRepository.getListFriend()).responseBody["result"];
  //   listFriendFilter.value = listFriend;
  // }

  void listenChangeOfListFriend() {
    listFriend.listen((p0) {
      listFriendFilter.value = p0;
    });
  }

  // this function to handle event onTap "DANH SÁCH"
  void onTapListTab() {
    pageController.jumpToPage(0);
    isOpenListTab.value = true;
  }

  // this function to handle event onTap BUTTON "KẾT BẠN"
  void onTapAddTab() {
    pageController.jumpToPage(1);
    isOpenListTab.value = false;
  }

  // this function to handle event when page change
  void onPageChange(int index) {
    isOpenListTab.value = !isOpenListTab.value;
    indexPage.value = index;
  }

  // this function to handle event onTap
  // textfield input phone number
  void onTapTextField() {
    errorPhoneNumber.value = "";
  }

  // this function to handle event onTap button
  // find user by phone number
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
      // check if user not exist with phone number which need get info user
      if (response.error && response.statusCode == 404) {
        errorPhoneNumber.value = "Số điện thoại này chưa được đăng ký";
      } else if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = response.responseBody;
        // check add friend request status
        final Map<String, dynamic> responseCheckAddFriendRequest = (await userRepository.checkAddFriendRequest(responseBody["_id"])).responseBody;

        AddFriendStatus addFriendStatus;

        // if STATUS is friend
        // => popup show button "HUỶ KẾT BẠN", "NHẮN TIN"
        if (responseCheckAddFriendRequest["message"] == "is friend") {
          addFriendStatus = AddFriendStatus.isFriend;
        } else if (responseCheckAddFriendRequest["message"] == "have send add friend request") {
        // if STATUS is HAVE SEND REQUEST
        // => popup show button "HUỶ GỬI"
          addFriendStatus = AddFriendStatus.haveSendAddFriendRequest;
        } else if (responseCheckAddFriendRequest["message"] == "have receive add friend request") {
        // if STATUS is HAVE SEND REQUEST
        // => popup show button "TỪ CHỐI", "CHẤP NHẬN"
          addFriendStatus = AddFriendStatus.haveReceiveAddFriendRequest;
        } else {
        // if STATUS is NO SEND REQUEST
        // => popup show button "KẾT BẠN"
          addFriendStatus = AddFriendStatus.noAddFriendRequest;
        }
        // open info of user finding
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

  // this function to handle event onPress BUTTON "KẾT BẠN"
  void onPressAddFriend(String id) {
    // emit event to socket
    socketController.emitAddFriend(id);
    Get.back();
  }

  // this function to handle event
  // onTap ICON 'TICK' to ACCEPT add friend request
  void onTapAcceptAddFriendRequest(String fromId, String toId) {
    socketController.emitAcceptAddFriendRequest(fromId, toId);
  }

  // this function to handle event on change
  // of text field find friend, with input is friend's name
  void onChangeTextFieldFindFriend(String value) {
    listFriendFilter.value = listFriend.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
  }
}