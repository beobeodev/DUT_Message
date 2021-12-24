import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/drawer/controllers/drawer_screen_controller.dart';
import 'package:flutter_frontend/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final DrawerScreenController drawerScreenController = Get.put(DrawerScreenController());
  final ProfileController profileController = Get.put(ProfileController());

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
                key: profileController.profileFormKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: drawerScreenController.openDrawer,
                          child: Icon(
                            FontAwesomeIcons.bars,
                            color: Palette.zodiacBlue,
                          ),
                        ),
                        Text(
                          "Thông tin cá nhân",
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontFamily: FontFamily.fontNunito,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: profileController.isUpdate.value
                              ? profileController.onTapUpdate
                              : () {},
                          child: Opacity(
                            opacity: profileController.isUpdate.value ? 1 : 0,
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.crayolaBlue,
                              ),
                              child: Icon(
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
                        Text(
                          "Ảnh đại diện",
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
                          onTap:  profileController.onTapAvatar,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              profileController.currentUser.value.avatar,
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
                        Text(
                          "Tên",
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: ScreenUtil().screenWidth/2 + 50,
                          child: TextFormField(
                            controller: profileController.nameEditingController,
                            onChanged: profileController.onChangeTextfieldName,
                            validator: profileController.validateName,
                            decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue,
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
                        Text(
                          "Email",
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: ScreenUtil().screenWidth/2 + 50,
                          child: TextFormField(
                            controller: profileController.emailEditingController,
                            onChanged: profileController.onChangeTextfieldEmail,
                            validator: profileController.validateEmail,
                            decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue,
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
                        Text(
                          "Số điện thoại",
                          style: TextStyle(
                            color: Palette.zodiacBlue,
                            fontSize: 17,
                            fontFamily: FontFamily.fontNunito,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        SizedBox(
                          width: ScreenUtil().screenWidth/2 + 50,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              isDense: true,
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.sweetRed,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Palette.blue,
                                  width: 1.5,
                                ),
                              ),
                              hintText: profileController.currentUser.value.phone,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (profileController.isLoading.value) DecoratedBox(
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
