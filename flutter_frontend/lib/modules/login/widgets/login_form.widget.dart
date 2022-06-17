import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/generated/locales.g.dart';
import 'package:flutter_frontend/modules/login/controllers/login.controller.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            RoundedTextFormField(
              textController: controller.usernameTextController,
              hintText: LocaleKeys.text_username.tr,
              prefixIcon: const Icon(
                FontAwesomeIcons.user,
                color: Palette.blue200,
                size: 18,
              ),
              validator: controller.validateUsername,
            ),
            SizedBox(
              height: 15.h,
            ),
            RoundedTextFormField(
              textController: controller.passwordTextController,
              hintText: LocaleKeys.text_password.tr,
              prefixIcon: const Icon(
                FontAwesomeIcons.lock,
                color: Palette.blue200,
                size: 18,
              ),
              suffixIcon: GestureDetector(
                onTap: controller.changeShowPassword,
                child: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: controller.showPassword.value
                      ? Palette.blue200
                      : Colors.grey,
                  size: 18,
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
