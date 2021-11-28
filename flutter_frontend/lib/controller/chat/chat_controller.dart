import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:flutter_frontend/widgets/chat/select_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final FirebaseRepository firebaseRepository = FirebaseRepository();

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    homeController.listConversation.listen((p0) {
      Timer(Duration(milliseconds: 200), () => {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent)
        }
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
    if (inputEditingController.text != "") {
      socketController.emitSendConversationMessage(
        conversationId: homeController.listConversation[indexConversation].id,
        fromId: localRepository.infoCurrentUser.id,
        toId: friendUser.id,
        content: inputEditingController.text,
      );
      inputEditingController.clear();
    }
    // currentConversation.update((val) {
    //   val.listMessage.add(Message(
    //     author: localRepository.infoCurrentUser,
    //     content: inputEditingController.text,
    //     timeSend: DateTime.now().toUtc(),
    //   ),);
    // });
    // update();
  }

  Future<void > showFilePicker(FileType fileType) async {
    final FilePickerResult result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      final File file = File(result.files.single.path);
      final int sizeInBytes = file.lengthSync();
      final double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 15) {
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Icon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: Colors.yellow,
                  size: ScreenUtil().setSp(72),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Vui lòng chọn tệp có kích thước nhỏ hơn 15 MB!",
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    color: Palette.zodiacBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(25),
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      } else {
        final String url = await firebaseRepository.uploadToFireStorage(fileType, file);
        socketController.emitSendConversationMessage(
          conversationId: homeController.listConversation[indexConversation].id,
          fromId: localRepository.infoCurrentUser.id,
          toId: friendUser.id,
          content: url,
          isImg: true,
        );
      }
    }
  }

  Future<void> showSelectModalBottom() async {
    await showModalBottomSheet(
      context: Get.context,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SelectBottomSheet(
          onPressItem: showFilePicker,
        );
      }
    );
  }
}