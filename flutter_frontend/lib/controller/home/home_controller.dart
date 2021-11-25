import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  // final User currentUser = localRepository.getCurrentUser();


  //Handle event on tap message
  void onTapMessage() {
    //Navigate to chat screen with detail message
    Get.toNamed<dynamic>(GetRouter.chat);
  }
}