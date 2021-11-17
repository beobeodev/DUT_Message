import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepository localRepository = LocalRepository();

  @override
  void onInit() {
    super.onInit();
    completeAnimation();
  }

  Future<void> completeAnimation() async {
    await Future<void>.delayed(Duration(milliseconds: 1600));
    if (localRepository.getNewUser() == null || localRepository.getNewUser() == false) {
      Get.offAllNamed(GetRouter.onboard);
    } else if (localRepository.getAccessToken() != null) {
      Get.offAllNamed(GetRouter.drawer);
    } else {
      Get.offAllNamed(GetRouter.login);
    }
  }
}
