import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/generated/locales.g.dart';
import 'package:flutter_frontend/modules/sign_up/controllers/sign_up.controller.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpForm extends GetView<SignUpController> {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Obx(() {
        return Column(
          children: [
            RoundedTextFormField(
              textController: controller.nameTextController,
              hintText: LocaleKeys.text_name.tr,
              prefixIcon: const Icon(
                FontAwesomeIcons.user,
                color: Palette.blue100,
                size: 18,
              ),
              validator: controller.validateName,
            ),
            SizedBox(
              height: 15.h,
            ),
            RoundedTextFormField(
              textController: controller.usernameTextController,
              hintText: LocaleKeys.text_username.tr,
              errorText: controller.errorUsername.value,
              prefixIcon: const Icon(
                FontAwesomeIcons.user,
                color: Palette.blue100,
                size: 18,
              ),
              validator: controller.validateUsername,
            ),
            SizedBox(
              height: 15.h,
            ),
            RoundedTextFormField(
              textController: controller.phoneTextController,
              hintText: LocaleKeys.text_phone.tr,
              errorText: controller.errorPhoneNumber.value,
              prefixIcon: const Icon(
                FontAwesomeIcons.phone,
                color: Palette.blue100,
                size: 18,
              ),
              validator: controller.validatePhoneNumber,
            ),
            SizedBox(
              height: 15.h,
            ),
            RoundedTextFormField(
              textController: controller.passwordTextController,
              hintText: LocaleKeys.text_password.tr,
              prefixIcon: const Icon(
                FontAwesomeIcons.lock,
                color: Palette.blue100,
                size: 18,
              ),
              suffixIcon: GestureDetector(
                onTap: () {},
                child: const Icon(
                  FontAwesomeIcons.solidEyeSlash,
                  color: Palette.gray300,
                  size: 18,
                ),
              ),
              isObscure: true,
              validator: controller.validatePassword,
            ),
            SizedBox(
              height: 15.h,
            ),
            RoundedTextFormField(
              textController: controller.confirmPasswordTextController,
              hintText: LocaleKeys.text_confirm_password.tr,
              prefixIcon: const Icon(
                FontAwesomeIcons.lock,
                color: Palette.blue100,
                size: 18,
              ),
              suffixIcon: GestureDetector(
                onTap: () {},
                child: const Icon(
                  FontAwesomeIcons.solidEyeSlash,
                  color: Palette.gray300,
                  size: 18,
                ),
              ),
              isObscure: true,
              validator: controller.validateConfirmPassword,
            ),
          ],
        );
      }),
    );
  }
}
