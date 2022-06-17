import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/login/controllers/forgot_password.controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () =>
          ForgotPasswordController(authRepository: getIt.get<AuthRepository>()),
    );
  }
}
