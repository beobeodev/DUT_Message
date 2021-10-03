import 'package:flutter_frontend/core/router/router.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  void navigateToSignUpScreen() {
    Get.toNamed<dynamic>(GetRouter.signUp);
  }
}
