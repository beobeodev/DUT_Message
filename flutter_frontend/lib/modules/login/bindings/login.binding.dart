import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/login/controllers/login.controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(
        authRepository: getIt.get<AuthRepository>(),
        localRepository: getIt.get<HiveLocalRepository>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
