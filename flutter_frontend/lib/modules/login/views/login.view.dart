import 'package:flutter/material.dart';
import 'package:flutter_frontend/generated/locales.g.dart';
import 'package:flutter_frontend/modules/login/controllers/login.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/login/widgets/login_form.widget.dart';
import 'package:flutter_frontend/modules/login/widgets/rounded_button.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              color: Palette.gray100,
            ),
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 20,
            ),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: ScreenUtil().screenWidth - 50,
                      height: ScreenUtil().setHeight(230),
                      child: Image.asset(
                        ImagePath.schoolPicture,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.text_login.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.fontNunito,
                          color: Palette.zodiacBlue,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const LoginForm(),
                  SizedBox(
                    height: 30.h,
                  ),
                  Obx(
                    () => RoundedButton(
                      onPressed: controller.onTapLoginButton,
                      content: LocaleKeys.text_login.tr,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chưa có tài khoản? ',
                        style: TextStyle(
                          color: Palette.zodiacBlue,
                          fontFamily: FontFamily.fontPoppins,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.navigateToSignUpScreen,
                        child: Text(
                          'ĐĂNG KÝ',
                          style: TextStyle(
                            color: Palette.blue100,
                            fontFamily: FontFamily.fontPoppins,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
