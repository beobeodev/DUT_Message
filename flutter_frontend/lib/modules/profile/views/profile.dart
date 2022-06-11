import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).padding.top + 6,
              ),
              child: Form(
                key: controller.profileFormKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: controller.rootController.openDrawer,
                          child: const Icon(
                            FontAwesomeIcons.bars,
                            color: Palette.zodiacBlue,
                          ),
                        ),
                        const Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontFamily: FontFamily.fontNunito,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.isUpdate.value
                              ? controller.onTapUpdate
                              : () {},
                          child: Opacity(
                            opacity: controller.isUpdate.value ? 1 : 0,
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.blue100,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Ảnh đại diện',
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(45),
                        ),
                        GestureDetector(
                          onTap: controller.onTapAvatar,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              controller.currentUser.value.avatar,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Tên',
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: ScreenUtil().screenWidth / 2 + 50,
                          child: TextFormField(
                            controller: controller.nameEditingController,
                            onChanged: controller.onChangeTextfieldName,
                            validator: controller.validateName,
                            decoration: const InputDecoration(
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue100,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue100,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: ScreenUtil().screenWidth / 2 + 50,
                          child: TextFormField(
                            controller: controller.emailEditingController,
                            onChanged: controller.onChangeTextfieldEmail,
                            validator: controller.validateEmail,
                            decoration: const InputDecoration(
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue100,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue100,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Số điện thoại',
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: ScreenUtil().screenWidth / 2 + 50,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              isDense: true,
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.red100,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue100,
                                  width: 1.5,
                                ),
                              ),
                              hintText: controller.currentUser.value.phone,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value)
              const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
