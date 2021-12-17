import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/repositories/auth_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController usernameEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController confirmPasswordEditingController = TextEditingController();

  final RxString errorUsername = "".obs;
  final RxString errorPhoneNumber = "".obs;
  final RxBool isLoading = false.obs;

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  void navigateToLoginScreen() {
    // Get.back<dynamic>();
    Get.offAndToNamed<dynamic>(GetRouter.login);
  }


  String validateName(String value) {
    if (value == "") {
      return "Tên không được để trống";
    }
    return null;
  }

  String validateUsername(String value) {
    if (value == "") {
      return "Tên đăng nhập không được để trống";
    }
    return null;

  }

  String validatePhoneNumber(String value) {
    if (value == "") {
      return "Số điện thoại không được để trống";
    }
    return null;

  }

  String validatePassword(String value) {
    if (value == "") {
      return "Mật khẩu không được để trống";
    } else if (value.length < 6) {
      return "Mật khẩu phải từ 6 kí tự trở lên";
    }
    return null;

  }

  String validateConfirmPassword(String value) {
    if (value == "") {
      return "Vui lòng xác nhận lại mật khẩu";
    } else if (passwordEditingController.text != confirmPasswordEditingController.text) {
      return "Mật khẩu xác nhận không khớp";
    }
    return null;

  }

  Future<void> onTapSignUpButton() async {
    if (!signUpFormKey.currentState.validate()) {
      return;
    } else {
      isLoading.value = true;
      final Map<String, String> body = {
        "name": nameEditingController.text,
        "username": usernameEditingController.text,
        "phone": phoneEditingController.text,
        "password": passwordEditingController.text,
      };
      final CustomResponse response = await authRepository.signUp(body);
      if (response.statusCode == 400) {
        isLoading.value = false;
        errorUsername.value = response.errorMaps["usernameExist"] ? "Tên đăng nhập đã tồn tại" : "";
        errorPhoneNumber.value = response.errorMaps["phoneExist"] ? "Số điện thoại đã tồn tại" : "";
        return;
      } else if (response.statusCode == 201) {
        isLoading.value = false;
        Timer _timer;
        await showDialog(
            context: Get.context,
            builder: (BuildContext builderContext) {
              _timer = Timer(Duration(milliseconds: 600), () {
                Get.back();
              });

              return  AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: ScreenUtil().setSp(72),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Đăng ký thành công!",
                      style: TextStyle(
                          fontFamily: FontFamily.fontNunito,
                          color: Palette.zodiacBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(25),
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            },
        ).then((val){
          if (_timer.isActive) {
            _timer.cancel();
          }
        });
        navigateToLoginScreen();
      }
    }
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context).requestFocus(FocusNode());
  }
}
