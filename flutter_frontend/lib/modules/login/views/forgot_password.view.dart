import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/login/controllers/forgot_password.controller.dart';
import 'package:flutter_frontend/modules/login/widgets/rounded_button.widget.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.forgotPasswordKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedTextFormField(
                textController: controller.emailTextController,
                hintText: 'Email',
                validator: controller.validateEmail,
              ),
              SizedBox(
                height: 15.h,
              ),
              RoundedButton(
                onPressed: controller.onTapButtonGetPassword,
                content: 'Lấy lại mật khẩu',
                isLoading: controller.isLoading.value,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Palette.gray100,
    );
  }
}
