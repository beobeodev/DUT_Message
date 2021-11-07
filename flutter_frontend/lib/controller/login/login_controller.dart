import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/repositories/login_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final TextEditingController usernameEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final LoginRepository loginRepository = LoginRepository();

  final RxString errorText = "".obs;

  void navigateToSignUpScreen() {
    Get.offAndToNamed<dynamic>(GetRouter.signUp);
  }

  Future<void> onTapLoginButton() async {
    http.Response response = await loginRepository.login(usernameEditingController.text, passwordEditingController.text);
    if (response.statusCode == 200) {
      final dynamic loginResponse = jsonDecode(response.body);
      Get.offAndToNamed<dynamic>(GetRouter.home, arguments: loginResponse);
    } else if (response.statusCode == 500) {
      errorText.value = "Incorrect username or password";
      print(errorText.value);
    }
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context).requestFocus(FocusNode());
  }

}
