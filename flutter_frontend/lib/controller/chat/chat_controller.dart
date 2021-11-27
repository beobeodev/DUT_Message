import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final LocalRepository localRepository = LocalRepository();

  final HomeController homeController = Get.put(HomeController());
  final SocketController socketController = Get.put(SocketController());

  final int indexConversation = Get.arguments;

  final ScrollController scrollController = ScrollController();
  final TextEditingController inputEditingController = TextEditingController();

  User friendUser;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      friendUser =  homeController.listConversation[indexConversation].listUserIn.firstWhere((element) => element.id != localRepository.infoCurrentUser.id,);
    }
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    homeController.listConversation.listen((p0) {
      Timer(Duration(milliseconds: 200), () => {
        scrollController.jumpTo(scrollController.position.maxScrollExtent),
      },);
    },);
  }

  //This function to handle event onTap back icon
  void onTapBackIcon() {
    Get.back();
  }

  void onTapSendButton() {
    // for (final item in currentConversation.listMessage) {
    //   print(item.toMap());
    // }
    // print(DateTime.now().toUtc());
    socketController.emitSendConversationMessage(
      homeController.listConversation[indexConversation].id,
      localRepository.infoCurrentUser.id,
      friendUser.id,
      inputEditingController.text,
    );
    // currentConversation.update((val) {
    //   val.listMessage.add(Message(
    //     author: localRepository.infoCurrentUser,
    //     content: inputEditingController.text,
    //     timeSend: DateTime.now().toUtc(),
    //   ),);
    // });
    // update();
    inputEditingController.clear();
  }

}