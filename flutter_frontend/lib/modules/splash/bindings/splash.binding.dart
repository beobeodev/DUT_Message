import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/splash/controllers/splash.controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(
        authController: Get.find<AuthController>(),
        hiveLocalRepository: getIt.get<HiveLocalRepository>(),
      ),
    );
  }
}
