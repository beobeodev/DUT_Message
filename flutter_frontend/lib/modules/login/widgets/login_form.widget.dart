import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/generated/locales.g.dart';
import 'package:flutter_frontend/modules/login/controllers/login.controller.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        child: Column(
          children: [
            RoundedTextFormField(
              textController: controller.usernameTextController,
              hintText: LocaleKeys.text_username.tr,
              suffixIconWidget: const Icon(
                Icons.mail,
                color: Palette.blue100,
              ),
              validator: controller.validateUsername,
            ),
            SizedBox(
              height: 15.h,
            ),
            RoundedTextFormField(
              textController: controller.passwordTextController,
              hintText: LocaleKeys.text_password.tr,
              suffixIconWidget: GestureDetector(
                onTap: controller.onUpdateShowPassword,
                child: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: controller.showPassword.value
                      ? Palette.blue200
                      : Colors.grey,
                ),
              ),
              validator: controller.validatePassword,
              isObscure: !controller.showPassword.value,
              errorText: controller.errorText.value,
            ),
          ],
        ),
      ),
    );
  }
}
