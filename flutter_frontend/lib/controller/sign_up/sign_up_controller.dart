import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  void navigateToLoginScreen() {
    Get.back<dynamic>();
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context).requestFocus(FocusNode());
  }
}
