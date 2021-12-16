import 'package:flutter_frontend/modules/drawer/controllers/drawer_screen_controller.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend_controller.dart';
import 'package:flutter_frontend/modules/home/controllers/home_controller.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:get/get.dart';

class DrawerBinding implements Bindings {
  @override
  void dependencies() {
    print("DrawerBinding init");
    Get.lazyPut(() => DrawerScreenController());
    Get.lazyPut(() => SocketController());
    Get.lazyPut(() => FriendController());
    Get.lazyPut(() => HomeController());
  }
}