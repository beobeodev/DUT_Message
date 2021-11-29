import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/widgets/chat/add_group_bottom_sheet.dart';
import 'package:get/get.dart';

class MenuChatController extends GetxController {
  final User friendUser = Get.arguments;

  Future<void> openBottomSheet() async {
    await showModalBottomSheet(
      context: Get.context,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddGroupBottomSheet();
      },
    );
  }
}