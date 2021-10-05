import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/config/router/router.dart';
import 'package:flutter_frontend/data/repositories/login_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController usernameEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final LoginRepository loginRepository = LoginRepository();

  void navigateToSignUpScreen() {
    Get.toNamed<dynamic>(GetRouter.signUp);
  }

  void onTapLoginButton() {
    loginRepository.login(usernameEditingController.text, passwordEditingController.text);
  }
}
