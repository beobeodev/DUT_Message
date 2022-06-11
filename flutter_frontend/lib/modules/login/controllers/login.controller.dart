import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  final HiveLocalRepository localRepository;
  final AuthController authController;

  LoginController({
    required this.authRepository,
    required this.localRepository,
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
    Get.toNamed(RouteManager.signUp);
  }

  Future<void> onTapLoginButton() async {
    errorText.value = '';
    if (isLoading.value) {
      return;
    }
    if (!loginFormKey.currentState!.validate()) {
      return;
    } else {
      isLoading.value = true;
      // final CustomResponse response = await authRepository.login(
      //   usernameEditingController.text,
      //   passwordEditingController.text,
      // );
      // if (response.statusCode == 200) {
      //   isLoading.value = false;
      //   Get.offAllNamed(RouteManager.drawer);
      // } else if (response.statusCode == 500) {
      //   if (response.errorMaps!['errorPassword'] != null) {
      //     isLoading.value = false;
      //     errorText.value = 'Sai tên đăng nhập hoặc mật khẩu';
      //   }
      // }
      final Map<String, dynamic> formBody = {
        'username': usernameTextController.text,
        'password': passwordTextController.text
      };

      try {
        final Map<String, dynamic> rawData =
            await authRepository.login(formBody);

        final User loggedUser = User.fromJson(rawData['user']);
        await localRepository.setAllNewUserData(
          rawData['accessToken'],
          rawData['refreshToken'],
          loggedUser.toJson(),
        );
        await authController.getAllUserData();
        Get.offAllNamed(RouteManager.drawer);
      } on DioError catch (dioError) {
        log(dioError.response.toString());
      } catch (e) {
        errorText.value = 'Sai tên đăng nhập hoặc mật khẩu';
        log(e.toString());
      }
      isLoading.value = false;
    }
  }
}
