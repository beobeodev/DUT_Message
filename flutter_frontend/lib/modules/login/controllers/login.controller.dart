import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  final AuthController authController;

  LoginController({
    required this.authRepository,
    required this.authController,
  });

  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final RxString errorText = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool showPassword = false.obs;

  String? validateUsername(String? value) {
    if (value == '') {
      return 'Vui lòng nhập tên đăng nhập';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == '') {
      return 'Vui lòng nhập mật khẩu';
    }
    return null;
  }

  void onUpdateShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void navigateToSignUpScreen() {
    Get.offAndToNamed(RouteManager.signUp);
  }

  Future<void> onTapLoginButton() async {
    errorText.value = '';

    if (isLoading.value || !loginFormKey.currentState!.validate()) {
      return;
    } else {
      isLoading.value = true;
      final Map<String, dynamic> formBody = {
        'username': usernameTextController.text,
        'password': passwordTextController.text
      };

      try {
        final Map<String, dynamic> rawData =
            await authRepository.login(formBody);

        final UserModel loggedUser = UserModel.fromJson(rawData['user']);
        await authController.handleSuccessLogin(
          loggedUser,
          rawData['accessToken'],
          rawData['refreshToken'],
        );

        Get.offAllNamed(RouteManager.drawer);
      } on DioError catch (dioError) {
        log('Error in onTapLoginButton: ${dioError.response.toString()}');
        if (dioError.response?.statusCode == 401) {
          errorText.value = 'Sai tên đăng nhập hoặc mật khẩu';
        }
      } catch (e) {
        log('Error in onTapLoginButton: ${e.toString()}');
      }
      isLoading.value = false;
    }
  }
}
