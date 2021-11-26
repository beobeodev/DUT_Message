import 'package:flutter_frontend/controller/drawer/drawer_controller.dart';
import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
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