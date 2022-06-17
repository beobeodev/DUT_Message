import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/sign_up/controllers/sign_up.controller.dart';
import 'package:get/get.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignUpController(authRepository: getIt.get<AuthRepository>()),
    );
  }
}
