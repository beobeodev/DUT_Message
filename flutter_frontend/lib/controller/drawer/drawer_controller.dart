import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enum.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DrawerScreenController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final SocketController socketController = Get.put(SocketController());

  //Check whether drawer is open or not
  final RxBool isDrawerOpen = false.obs;

  final RxDouble xOffset = 0.0.obs;
  final RxDouble yOffset = 0.0.obs;
  final RxDouble scaleFactor  = 1.0.obs;

  final Rx<CurrentScreen> currentPage = CurrentScreen.message.obs;

  //This list to store title and icon of menu item
  final List<Map<String, dynamic>> listMenuItem = [
    <String, dynamic>{
      "title": "Nhắn tin",
      "icon": FontAwesomeIcons.commentAlt,
    },
    <String, dynamic>{
      "title": "Bạn bè",
      "icon": FontAwesomeIcons.userFriends
    },
    <String, dynamic>{
      "title": "Hồ sơ",
      "icon": FontAwesomeIcons.idBadge,
    },
  ];

  //This function to implement close drawer
  void closeDrawer() {
    xOffset.value = 0.0;
    yOffset.value = 0.0;
    scaleFactor.value = 1;
    isDrawerOpen.value = false;
  }

  //This function to implement open drawer
  void openDrawer() {
    xOffset.value = 250;
    yOffset.value = 150;
    scaleFactor.value = 0.6;
    isDrawerOpen.value = true;
  }

  //This function to handle onTap event of menu item
  void onTapMenuItem(IconData icon) {
    if (icon == FontAwesomeIcons.commentAlt) {
      currentPage.value = CurrentScreen.message;
    } else if (icon == FontAwesomeIcons.userFriends) {
      currentPage.value = CurrentScreen.friend;
    } else if (icon == FontAwesomeIcons.idBadge) {
      currentPage.value = CurrentScreen.profile;
    } else {
      currentPage.value = CurrentScreen.addFriend;
    }
    closeDrawer();
  }

  //This function to handle event onTap of logout button
  Future<void> onTapLogoutButton() async {
    await localRepository.deleteToken();
    Get.offAllNamed(GetRouter.login);
  }
}