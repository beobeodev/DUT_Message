import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final UserRepository userRepository = UserRepository();

  final TextEditingController emailEditingController = TextEditingController();

  final GlobalKey<FormState> resetForm = GlobalKey<FormState>();

  final RxString errorEmail = "".obs;

  String validateEmail(String value) {
    if (value == "") {
      return "Vui lòng nhập email để reset mật khẩu";
    } else if (!value.isEmail) {
      return "Định dạng email chưa đúng";
    }
    return null;
  }

  Future<void> onPressButtonReset() async {
    if (!resetForm.currentState.validate()) {
      return;
    } else {
      final CustomResponse response = await userRepository.resetPassword(emailEditingController.text);
      if (response.statusCode == 401) {
        errorEmail.value = "Email này không tồn tại";
      } else if (response.statusCode == 200) {
        Timer _timer;
        await showDialog(
          context: Get.context,
          builder: (BuildContext builderContext) {
            _timer = Timer(Duration(milliseconds: 800), () {
              Get.back();
            });

            return  AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: ScreenUtil().setSp(72),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kiểm tra email của bạn!",
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
      }
      Get.back();
    }
  }
}