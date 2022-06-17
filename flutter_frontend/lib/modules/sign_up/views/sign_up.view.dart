import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/widgets/loading_dot.dart';
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
        child: SingleChildScrollView(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Palette.gray100,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                left: 25.w,
                right: 25.w,
              ),
              child: Form(
                key: controller.signUpFormKey,
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
                      GestureDetector(
                        onTap: controller.onTapSignUpButton,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Palette.red100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(55),
                            child: controller.isLoading.value
                                ? const LoadingDot()
                                : Center(
                                    child: Text(
                                      'Đăng ký',
                                      style: TextStyle(
                                        fontFamily: FontFamily.fontPoppins,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}
