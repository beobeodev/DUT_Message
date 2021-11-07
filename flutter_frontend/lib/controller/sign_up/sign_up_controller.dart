import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  void navigateToLoginScreen() {
    // Get.back<dynamic>();
    Get.offAndToNamed<dynamic>(GetRouter.login);
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context).requestFocus(FocusNode());
  }
}
