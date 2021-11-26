import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/conversation_repository.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final ConversationRepository conversationRepository = ConversationRepository();

  String accessToken;
  String refreshToken;
  User currentUser;

  final RxList<Conversation> listConversation = <Conversation>[].obs;

  @override
  void onInit() {
    super.onInit();
    // print((localRepository.getCurrentUser()).runtimeType);
    currentUser = User.fromMap(Map<String, dynamic>.from(localRepository.getCurrentUser()));
    accessToken = localRepository.getAccessToken();
    refreshToken = localRepository.getRefreshToken();
  }

  @override
  void onReady() {
    super.onReady();
    getListConversation();
  }

  Future<void> getListConversation() async {
    final CustomResponse customResponse = await conversationRepository.getListConversation(accessToken, refreshToken, currentUser.id);
    if (customResponse.statusCode == 200) {
      listConversation.value = customResponse.responseBody["result"];
    }
  }

  //Handle event on tap message
  void onTapMessage() {
    //Navigate to chat screen with detail message
    Get.toNamed<dynamic>(GetRouter.chat);
  }
}