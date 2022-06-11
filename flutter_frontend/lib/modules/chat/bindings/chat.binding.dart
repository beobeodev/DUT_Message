import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat.controller.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChatController(
        authController: Get.find<AuthController>(),
        firebaseRepository: getIt.get<FirebaseRepository>(),
        homeController: Get.find<HomeController>(),
        rootController: Get.find<RootController>(),
      ),
    );
  }
}