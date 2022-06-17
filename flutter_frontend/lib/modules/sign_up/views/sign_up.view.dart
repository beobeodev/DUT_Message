import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/login/widgets/rounded_button.widget.dart';
import 'package:flutter_frontend/modules/sign_up/controllers/sign_up.controller.dart';
import 'package:flutter_frontend/modules/sign_up/widgets/decorated_header.widget.dart';
import 'package:flutter_frontend/modules/sign_up/widgets/sign_up_form.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: controller.onUnFocus,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Palette.gray100,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20.w,
              MediaQuery.of(context).padding.top + 10,
              20.w,
              30.h,
            ),
            child: Obx(() {
              return Column(
                children: [
                  const DecoratedHeader(),
                  SizedBox(
                    height: 25.h,
                  ),
                  const SignUpForm(),
                  SizedBox(
                    height: 20.h,
                  ),
                  RoundedButton(
                    onPressed: controller.onTapSignUpButton,
                    content: 'Đăng ký',
                    isLoading: controller.isProcessing,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đã có tài khoản? ',
                        style: TextStyle(
                          color: Palette.zodiacBlue,
                          fontFamily: FontFamily.fontPoppins,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.navigateToLoginScreen,
                        child: Text(
                          'ĐĂNG NHẬP',
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
