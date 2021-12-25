import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/widgets/custom_text_form_field.dart';
import 'package:flutter_frontend/core/widgets/loading_dot.dart';
import 'package:flutter_frontend/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: signUpController.onUnFocus,
        child: SafeArea(
          child: SingleChildScrollView(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Palette.aliceBlue,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(30),
                  left: ScreenUtil().setWidth(25),
                  right: ScreenUtil().setWidth(25),
                ),
                child: Form(
                  key: signUpController.signUpFormKey,
                  child: Obx(() {
                    return Column(
                      children: [
                        SizedBox(
                          width: ScreenUtil().screenWidth - 180,
                          height: ScreenUtil().setHeight(70),
                          child: SvgPicture.asset(
                            ImagePath.profileSignUp,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tham gia DUT Message",
                            style: TextStyle(
                              fontFamily: FontFamily.fontPoppins,
                              color: Palette.lighterBlack,
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tạo tài khoản",
                            style: TextStyle(
                              fontFamily: FontFamily.fontNunito,
                              color: Palette.zodiacBlue,
                              fontSize: ScreenUtil().setSp(34),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        CustomTextFormField(
                          width: double.infinity,
                          hintText: "Name",
                          suffixIconWidget: Icon(
                            FontAwesomeIcons.user,
                            color: Palette.celticBlue,
                            size: 18,
                          ),
                          borderColor: Palette.celticBlue,
                          validateFunc: signUpController.validateName,
                          textEditingController: signUpController
                              .nameEditingController,
                        ),
                        CustomTextFormField(
                          width: double.infinity,
                          hintText: "Username",
                          suffixIconWidget: Icon(
                            FontAwesomeIcons.user,
                            color: Palette.celticBlue,
                            size: 18,
                          ),
                          errorText: signUpController.errorUsername.value,
                          borderColor: Palette.celticBlue,
                          validateFunc: signUpController.validateUsername,
                          textEditingController: signUpController
                              .usernameEditingController,
                        ),
                        CustomTextFormField(
                          width: double.infinity,
                          hintText: "Email",
                          suffixIconWidget: Icon(
                            Icons.email,
                            color: Palette.celticBlue,
                            size: 18,
                          ),
                          // errorText: signUpController.errorUsername.value,
                          borderColor: Palette.celticBlue,
                          validateFunc: signUpController.validateEmail,
                          textEditingController: signUpController.emailEditingController,
                        ),
                        CustomTextFormField(
                          width: double.infinity,
                          hintText: "Your phone number",
                          suffixIconWidget: Icon(
                            FontAwesomeIcons.phone,
                            color: Palette.celticBlue,
                            size: 18,
                          ),
                          errorText: signUpController.errorPhoneNumber.value,
                          borderColor: Palette.celticBlue,
                          validateFunc: signUpController.validatePhoneNumber,
                          textEditingController: signUpController
                              .phoneEditingController,
                        ),
                        CustomTextFormField(
                          width: double.infinity,
                          hintText: "Password",
                          suffixIconWidget: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.solidEyeSlash,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                          isObsecure: true,
                          borderColor: Palette.celticBlue,
                          validateFunc: signUpController.validatePassword,
                          textEditingController: signUpController
                              .passwordEditingController,
                        ),
                        CustomTextFormField(
                          width: double.infinity,
                          hintText: "Confirm password",
                          suffixIconWidget: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.solidEyeSlash,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                          isObsecure: true,
                          borderColor: Palette.celticBlue,
                          validateFunc: signUpController
                              .validateConfirmPassword,
                          textEditingController: signUpController
                              .confirmPasswordEditingController,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        GestureDetector(
                          onTap: signUpController.onTapSignUpButton,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Palette.sweetRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: ScreenUtil().setHeight(50),
                              child: signUpController.isLoading.value
                              ? LoadingDot(
                                size: 30,
                              ) :
                              Center(
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                    fontFamily: FontFamily.fontPoppins,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(22),
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
                              "Đã có tài khoản? ",
                              style: TextStyle(
                                color: Palette.zodiacBlue,
                                fontFamily: FontFamily.fontPoppins,
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(18),
                              ),
                            ),
                            GestureDetector(
                              onTap: signUpController.navigateToLoginScreen,
                              child: Text(
                                "ĐĂNG NHẬP",
                                style: TextStyle(
                                  color: Palette.celticBlue,
                                  fontFamily: FontFamily.fontPoppins,
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(18),
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
      ),
    );
  }
}



