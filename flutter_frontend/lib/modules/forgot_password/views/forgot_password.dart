import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/widgets/custom_text_form_field.dart';
import 'package:flutter_frontend/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Form(
            key: forgotPasswordController.resetForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  textEditingController: forgotPasswordController.emailEditingController,
                  width: ScreenUtil().screenWidth - 50,
                  validateFunc: forgotPasswordController.validateEmail,
                  hintText: "Nhập email của bạn để reset mật khẩu",
                  errorText: forgotPasswordController.errorEmail.value,
                  suffixIconWidget: Icon(
                    Icons.email,
                    size: 18,
                    color: Palette.celticBlue,
                  ),
                  borderColor: Palette.celticBlue,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Palette.sweetRed,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                  onPressed: forgotPasswordController.onPressButtonReset,
                  child: Text(
                    'Reset mật khẩu',
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
