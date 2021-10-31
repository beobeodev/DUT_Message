import 'package:flutter_frontend/core/router/router.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    completeAnimation();
  }

  Future<void> completeAnimation() async {
    await Future<void>.delayed(Duration(milliseconds: 1600));
    Get.offAndToNamed<dynamic>(GetRouter.login);
  }
}
