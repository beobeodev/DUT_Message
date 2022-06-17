import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/theme/text_styles.dart';
import 'package:flutter_frontend/modules/profile/controllers/profile.controller.dart';
import 'package:flutter_frontend/widgets/rounded_icon_button.widget.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Obx(
          () => Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).padding.top + 6,
            ),
            child: GestureDetector(
              onTap: () {
                log('message');
              },
              child: Form(
                key: controller.profileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: controller.rootController.openDrawer,
                          icon: const Icon(
                            Icons.menu,
                            color: Palette.red100,
                          ),
                        ),
                        Text(
                          'Thông tin cá nhân',
                          style: TextStyles.largeBoldText
                              .copyWith(fontSize: 24.sp, color: Palette.red100),
                        ),
                        Opacity(
                          opacity: controller.isUpdate.value ? 1 : 0,
                          child: RoundedIconButton(
                            icon: Icons.check,
                            size: 30,
                            onPressed: controller.isUpdate.value
                                ? controller.submitUpdateProfile
                                : () {},
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Align(
                      child: GestureDetector(
                        onTap: controller.onTapAvatar,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            controller.currentUser.value.avatar,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Tên',
                      style: TextStyles.largeRegularText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RoundedTextFormField(
                      textController: controller.nameEditingController,
                      onChanged: controller.onChangeTextfieldName,
                      validator: controller.validateName,
                      borderColor: Palette.red100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Email',
                      style: TextStyles.largeRegularText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RoundedTextFormField(
                      textController: controller.emailEditingController,
                      onChanged: controller.onChangeTextfieldEmail,
                      validator: controller.validateEmail,
                      borderColor: Palette.red100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Số điện thoại',
                      style: TextStyles.largeRegularText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RoundedTextFormField(
                      textController: controller.phoneEditingController,
                      borderColor: Palette.red100,
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Palette.gray100,
      ),
    );
  }
}
