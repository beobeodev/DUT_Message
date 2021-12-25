import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/widgets/custom_text_form_field.dart';
import 'package:flutter_frontend/core/widgets/loading_dot.dart';
import 'package:flutter_frontend/modules/login/controllers/login_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: loginController.onUnFocus,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Palette.aliceBlue,
              ),
              child: Obx(
              () {
                return Form(
                  key: loginController.loginFormKey,
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
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20.0),
                          left: ScreenUtil().setWidth(25.0),
                          right: ScreenUtil().setWidth(25.0),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  fontFamily: FontFamily.fontNunito,
                                  color: Palette.zodiacBlue,
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(25),
                            ),
                            CustomTextFormField(
                              textEditingController: loginController.usernameEditingController,
                              width: double.infinity,
                              validateFunc: loginController.validateUsername,
                              hintText: "Username",
                              suffixIconWidget: Icon(
                                FontAwesomeIcons.user,
                                size: 18,
                                color: Palette.celticBlue,
                              ),
                              borderColor: Palette.celticBlue,
                            ),
                            CustomTextFormField(
                              textEditingController: loginController.passwordEditingController,
                              width: double.infinity,
                              validateFunc: loginController.validatePassword,
                              hintText: "Password",
                              isObsecure: true,
                              errorText: loginController.errorText.value,
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: loginController.onTapForgotPass,
                                child: Text(
                                  "Quên mật khẩu?",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: FontFamily.fontNunito,
                                    fontSize: 16
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: loginController.onTapLoginButton,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Palette.sweetRed,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: ScreenUtil().setHeight(55),
                                  child: loginController.isLoading.value
                                    ? LoadingDot(size: 30,) : Center(
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                        fontFamily: FontFamily.fontNunito,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: ScreenUtil().setSp(23),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(25.0),
                            ),

                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Divider(
                            //         thickness: 1.2,
                            //       ),
                            //     ),
                            //     Text(
                            //       "OR",
                            //       style: TextStyle(
                            //         color: Palette.lighterBlack,
                            //         fontFamily: FontFamily.fontPoppins,
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: ScreenUtil().setSp(18),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Divider(
                            //         thickness: 1.2,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: ScreenUtil().setHeight(20.0),
                            // ),
                            // if (size.height <= 960)
                            //   BuildNarrowSocial(),
                            // if (size.height > 960)
                            //   BuildWideSocial(),
                            // SizedBox(
                            //   height: ScreenUtil().setHeight(25),
                            // ),
                            // Expanded(child: SizedBox(),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Chưa có tài khoản? ",
                                  style: TextStyle(
                                    color: Palette.zodiacBlue,
                                    fontFamily: FontFamily.fontPoppins,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(18),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: loginController.navigateToSignUpScreen,
                                  child: Text(
                                    "ĐĂNG KÝ",
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
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
