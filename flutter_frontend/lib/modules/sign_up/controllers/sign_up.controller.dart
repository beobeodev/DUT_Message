import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/widgets/rounded_alert_dialog.widget.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthRepository authRepository;

  SignUpController({required this.authRepository});

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  final RxString errorUsername = ''.obs;
  final RxString errorPhoneNumber = ''.obs;
  final RxBool isLoading = false.obs;

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  void navigateToLoginScreen() {
    Get.offAndToNamed(RouteManager.login);
  }

  String? validateName(String? value) {
    if (value == '') {
      return 'Tên không được để trống';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == '') {
      return 'Tên đăng nhập không được để trống';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == '') {
      return 'Số điện thoại không được để trống';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == '') {
      return 'Mật khẩu không được để trống';
    } else if (value!.length < 6) {
      return 'Mật khẩu phải từ 6 kí tự trở lên';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == '') {
      return 'Vui lòng xác nhận lại mật khẩu';
    } else if (passwordTextController.text !=
        confirmPasswordTextController.text) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  Future<void> onTapSignUpButton() async {
    if (isLoading.value == true || !signUpFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    final Map<String, String> formBody = {
      'name': nameTextController.text,
      'username': usernameTextController.text,
      'phone': phoneTextController.text,
      'password': passwordTextController.text,
    };
    await handleSignUp(formBody);

    isLoading.value = false;
  }

  Future<void> handleSignUp(Map<String, dynamic> formBody) async {
    try {
      await authRepository.signUp(formBody);
      // Show success dialog
      Timer? timer;
      await showDialog(
        context: Get.context!,
        builder: (BuildContext builderContext) {
          timer = Timer(const Duration(milliseconds: 600), () {
            Get.back();
          });

          return const RoundedAlertDialog(
            icon: Icons.check,
            content: 'Đăng ký thành công!',
          );
        },
      ).then((val) {
        if (timer!.isActive) {
          timer!.cancel();
        }
      });
      navigateToLoginScreen();
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 400) {
        final Map<String, dynamic> errorResponse =
            dioError.response?.data['validate'];
        errorUsername.value =
            errorResponse['usernameExist'] ? 'Tên đăng nhập đã tồn tại' : '';
        errorPhoneNumber.value =
            errorResponse['phoneExist'] ? 'Số điện thoại đã tồn tại' : '';
      }
    }
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }
}
