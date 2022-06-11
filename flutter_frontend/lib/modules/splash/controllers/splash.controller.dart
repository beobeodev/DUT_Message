import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AuthController authController;
  final HiveLocalRepository hiveLocalRepository;

  SplashController({
    required this.authController,
    required this.hiveLocalRepository,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    await completeAnimation();
  }

  Future<void> completeAnimation() async {
    await hiveLocalRepository.getAllNewUserData();
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (authController.isNewUser == null || authController.isNewUser == false) {
      Get.offAllNamed(RouteManager.onboard);
    } else if (authController.accessToken != null) {
      // await initData();
      Get.offAllNamed(RouteManager.drawer);
    } else {
      Get.offAllNamed(RouteManager.login);
    }
  }

  // Future<void> initData() async {
  //   try {
  //     await localRepository.initData();
  //     await conversationRepository.getListConversationAndRoom();
  //     await userRepository.initData();
  //   } catch (e) {
  //     print('Error in initData() from SplashController: $e');
  //   }
  // }
}
