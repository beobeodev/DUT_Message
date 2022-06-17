import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/login/controllers/forgot_password.controller.dart';
import 'package:flutter_frontend/modules/login/widgets/rounded_button.widget.dart';
import 'package:flutter_frontend/widgets/rounded_icon_button.widget.dart';
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
        child: Obx(() {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).padding.top + 15,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: RoundedIconButton(
                    size: 30,
                    iconSize: 25,
                    icon: Icons.chevron_left,
                    backgroundColor: Palette.red100,
                    onPressed: () {
                      Get.offAllNamed(RouteManager.login);
                    },
                  ),
                ),
                const Spacer(),
                RoundedTextFormField(
                  textController: controller.emailTextController,
                  hintText: 'Nhập email của bạn',
                  validator: controller.validateEmail,
                  errorText: controller.errorEmail.value,
                ),
                SizedBox(
                  height: 15.h,
                ),
                RoundedButton(
                  onPressed: controller.onTapButtonGetPassword,
                  content: 'Lấy lại mật khẩu',
                  isLoading: controller.isProcessing.value,
                ),
                const Spacer(),
              ],
            ),
          );
        }),
      ),
      backgroundColor: Palette.gray100,
    );
  }
}
