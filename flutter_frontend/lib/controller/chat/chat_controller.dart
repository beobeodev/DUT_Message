import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final LocalRepository localRepository = LocalRepository();

  final SocketController socketController = Get.put(SocketController());

  final Conversation currentConversation = Get.arguments;

  final TextEditingController inputEditingController = TextEditingController();

  //This function to handle event onTap back icon
  void onTapBackIcon() {
    Get.back();
  }

  void onTapSendButton() {
    // for (final item in currentConversation.listMessage) {
    //   print(item.toMap());
    // }
    socketController.emitSendConversationMessage(
      currentConversation.id,
      localRepository.infoCurrentUser.id,
      currentConversation.listUserIn.firstWhere(
        (element) => element.id != localRepository.infoCurrentUser.id,).id,
      inputEditingController.text,
    );
  }
}