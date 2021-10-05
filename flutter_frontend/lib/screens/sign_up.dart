import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/config/constants/font_family.dart';
import 'package:flutter_frontend/config/constants/image_path.dart';
import 'package:flutter_frontend/config/theme/palette.dart';
import 'package:flutter_frontend/controller/sign_up/sign_up_controller.dart';
import 'package:flutter_frontend/widgets/widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Palette.aliceBlue,
            ),
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(30),
                  left: ScreenUtil().setWidth(25),
                  right: ScreenUtil().setWidth(25),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(120),
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
                        "Join DUT Message",
                        style: TextStyle(
                          fontFamily: FontFamily.fontPoppins,
                          color: Palette.lighterBlack,
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          fontFamily: FontFamily.fontPoppins,
                          color: Palette.zodiacBlue,
                          fontSize: ScreenUtil().setSp(38),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    CustomTextFormField(
                      width: double.infinity,
                      hintText: "Username",
                      suffixIconWidget: Icon(
                        FontAwesomeIcons.user,
                        color: Palette.celticBlue,
                        size: 18,
                      ),
                      borderColor: Palette.celticBlue,
                    ),
                    CustomTextFormField(
                      width: double.infinity,
                      hintText: "Your phone number",
                      suffixIconWidget: Icon(
                        FontAwesomeIcons.phone,
                        color: Palette.celticBlue,
                        size: 18,
                      ),
                      borderColor: Palette.celticBlue,
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
                      borderColor: Palette.celticBlue,
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
                      borderColor: Palette.celticBlue,
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Palette.sweetRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(55),
                        child: Center(
                          child: Text(
                            "Log in",
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
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
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
                            "LOG IN",
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



