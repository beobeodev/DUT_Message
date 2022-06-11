import 'package:flutter_frontend/data/repositories/conversation.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        authController: Get.find<AuthController>(),
        conversationRepository: getIt.get<ConversationRepository>(),
        rootController: Get.find<RootController>(),
      ),
    );
  }
}
