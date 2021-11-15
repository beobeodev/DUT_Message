import 'package:flutter_frontend/core/router/router.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  //Handle event on tap message
  void onTapMessage() {
    //Navigate to chat screen with detail message
    Get.toNamed<dynamic>(GetRouter.chat);
  }
}