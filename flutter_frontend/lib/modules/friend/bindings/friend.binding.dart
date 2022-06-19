import 'package:flutter_frontend/data/repositories/user.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class FriendBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FriendController(
        userRepository: getIt.get<UserRepository>(),
        // socketController: Get.find<SocketController>(),
        homeController: Get.find<HomeController>(),
        authController: Get.find<AuthController>(),
        rootController: Get.find<RootController>(),
      ),
    );
  }
}
