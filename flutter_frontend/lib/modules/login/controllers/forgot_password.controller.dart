import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/widgets/rounded_alert_dialog.widget.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository authRepository;

  ForgotPasswordController({required this.authRepository});

  final TextEditingController emailTextController = TextEditingController();
  final GlobalKey<FormState> forgotPasswordKey = GlobalKey<FormState>();

  final RxBool isProcessing = false.obs;
  final RxString errorEmail = ''.obs;

  String? validateEmail(String? value) {
    if (value == '') {
      return 'Nhập email của tài khoản';
    } else if (value != null && !value.isEmail) {
      return 'Nhập đúng định dạng email';
    }
    return null;
  }

  Future<void> onTapButtonGetPassword() async {
    if (isProcessing.value == true) {
      return;
    }

    if (!forgotPasswordKey.currentState!.validate()) {
      return;
    }

    isProcessing.value = true;

    try {
      final Map<String, dynamic> formBody = {'email': emailTextController.text};

      await authRepository.forgotPassword(formBody);
      await showSuccessDialog();

      navigateToLoginScreen();
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 401) {
        errorEmail.value = 'Email không tồn tại';
      }
    }

    isProcessing.value = false;
  }

  void navigateToLoginScreen() {
    Get.offAndToNamed(RouteManager.login);
  }

  Future<void> showSuccessDialog() async {
    final Timer timer = Timer(const Duration(milliseconds: 1000), () {
      Get.back();
    });

    await showDialog(
      context: Get.context!,
      builder: (BuildContext builderContext) {
        return const RoundedAlertDialog(
          icon: Icons.check,
          content: 'Kiểm tra email của bạn!',
        );
      },
    ).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }
}
