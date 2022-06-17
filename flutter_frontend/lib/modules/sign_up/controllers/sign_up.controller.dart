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
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  final RxString errorUsername = ''.obs;
  final RxString errorPhoneNumber = ''.obs;

  final RxBool _isProcessing = false.obs;
  bool get isProcessing => _isProcessing.value;

  final RxBool _showPassword = false.obs;
  bool get showPassword => _showPassword.value;
  final RxBool _showConfirmPassword = false.obs;
  bool get showConfirmPassword => _showConfirmPassword.value;

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

  String? validateEmail(String? value) {
    if (value == '') {
      return 'Email không được để trống';
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
    if (isProcessing == true) {
      return;
    }

    if (!signUpFormKey.currentState!.validate()) {
      return;
    }

    _isProcessing.value = true;

    final Map<String, String> formBody = {
      'name': nameTextController.text,
      'username': usernameTextController.text,
      'phone': phoneTextController.text,
      'email': emailTextController.text,
      'password': passwordTextController.text,
    };
    await handleSignUp(formBody);

    _isProcessing.value = false;
  }

  Future<void> handleSignUp(Map<String, dynamic> formBody) async {
    try {
      await authRepository.signUp(formBody);
      // Show success dialog
      await showSuccessDialog();

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

  Future<void> showSuccessDialog() async {
    final Timer timer = Timer(const Duration(milliseconds: 600), () {
      Get.back();
    });

    await showDialog(
      context: Get.context!,
      builder: (BuildContext builderContext) {
        return const RoundedAlertDialog(
          icon: Icons.check,
          content: 'Đăng ký thành công!',
        );
      },
    ).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  void changeShowPassword() {
    _showPassword.value = !_showPassword.value;
  }

  void changeShowConfirmPassword() {
    _showConfirmPassword.value = !_showConfirmPassword.value;
  }
}
