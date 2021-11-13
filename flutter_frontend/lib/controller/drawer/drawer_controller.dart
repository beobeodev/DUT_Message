import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DrawerScreenController extends GetxController {
  //Check whether drawer is open or not
  final RxBool isDrawerOpen = false.obs;

  final RxDouble xOffset = 0.0.obs;
  final RxDouble yOffset = 0.0.obs;
  final RxDouble scaleFactor  = 1.0.obs;

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
    <String, dynamic>{
      "title": "Kết bạn",
      "icon": FontAwesomeIcons.userPlus,
    }
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

}