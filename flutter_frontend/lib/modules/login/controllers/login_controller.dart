import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/repositories/auth_repository.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  final TextEditingController usernameEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final AuthRepository authRepository = AuthRepository();
  
  final RxString errorText = "".obs;
  final RxBool isLoading = false.obs;


  String validateUsername(String value) {
    if (value == "") {
      return "Vui lòng nhập tên đăng nhập";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value == "") {
      return "Vui lòng nhập mật khẩu";
    }
    return null;
  }

  void navigateToSignUpScreen() {
    Get.offAndToNamed<dynamic>(GetRouter.signUp);
  }

  Future<void> onTapLoginButton() async {
    errorText.value = "";
    if (!loginFormKey.currentState.validate()) {
      return;
    } else {
      isLoading.value = true;
      final CustomResponse response = await authRepository.login(usernameEditingController.text, passwordEditingController.text);
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.offAllNamed(GetRouter.drawer);
      } else if (response.statusCode == 500) {
        if (response.errorMaps['errorPassword'] != null) {
          isLoading.value = false;
          errorText.value = "Sai tên đăng nhập hoặc mật khẩu";
        }
      }
    }
  }

  //This function to hide keyboard and unfocus textfield
  void onUnFocus() {
    FocusScope.of(Get.context).requestFocus(FocusNode());
  }


}
