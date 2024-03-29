import 'package:flutter_frontend/modules/drawer/controllers/drawer_screen_controller.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/conversation_repository.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final ConversationRepository conversationRepository = ConversationRepository();

  final DrawerScreenController drawerScreenController = Get.put(DrawerScreenController());

  RxList<Conversation> listConversationAndRoom = <Conversation>[].obs;

  User currentUser;

  @override
  void onInit() {
    super.onInit();
    // get list conversation from repository;
    listConversationAndRoom.value = conversationRepository.listConversationAndRoom;
    currentUser = localRepository.infoCurrentUser;
  }

  //Handle event on tap message
  void onTapConversation(int index) {
    //Navigate to chat screen with detail message
    Get.toNamed(GetRouter.chat, arguments: [listConversationAndRoom[index], listConversationAndRoom[index].isRoom]);
  }
}