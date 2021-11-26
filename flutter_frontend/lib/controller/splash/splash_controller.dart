import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/repositories/conversation_repository.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final ConversationRepository conversationRepository = ConversationRepository();
  final UserRepository userRepository = UserRepository();

  @override
  void onInit() {
    super.onInit();
    completeAnimation();
  }

  Future<void> completeAnimation() async {
    await Future<void>.delayed(Duration(milliseconds: 1600));
    if (localRepository.getNewUser() == null || localRepository.getNewUser() == false) {
      Get.offAllNamed(GetRouter.onboard);
    } else if (localRepository.getAccessToken() != null) {
      await initData();
      Get.offAllNamed(GetRouter.drawer);
    } else {
      Get.offAllNamed(GetRouter.login);
    }
  }

  Future<void> initData() async {
    try {
      localRepository.initData();
      await conversationRepository.getListConversation();
      await userRepository.initData();
    } catch (e) {
      print("Error in initData() from SplashController: $e");
    }
  }
}
