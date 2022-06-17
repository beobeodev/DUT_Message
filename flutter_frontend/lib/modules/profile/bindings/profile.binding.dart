import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/profile/controllers/profile.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileController(
        authController: Get.find<AuthController>(),
        rootController: Get.find<RootController>(),
        userRepository: getIt.get<UserRepository>(),
        firebaseRepository: getIt.get<FirebaseRepository>(),
      ),
    );
  }
}
