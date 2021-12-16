import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/conversation_repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/widgets/chat/bottom_sheet/add_group_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuChatController extends GetxController {
  final UserRepository userRepository = UserRepository();
  final ConversationRepository conversationRepository = ConversationRepository();

  final dynamic infoConversation = Get.arguments;

  final SocketController socketController = Get.put(SocketController());

  final TextEditingController findEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();


  List<Map<String, dynamic>> listFriend = <Map<String, dynamic>>[];
  final RxList<Map<String, dynamic>> listSearchFriend = <Map<String, dynamic>>[].obs;
  List<String> listIDSelectedFriend;
  // final RxList<Map<String, dynamic>> listFilterFriend = <Map<String, dynamic>>[].obs;
  // final RxList<bool> listCheckSelectedFriend = <bool>[].obs;
  // final RxList<User> listSelectedFriend = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (infoConversation is User) {
      // get list friend with condition have not id of friend
      // who is chatting
      listFriend = List.from(userRepository.listFriend).toList().where((element) => element.id != infoConversation.id).map((e) {
        return {
          "user": e,
          "beSelected": false,
        };
      }).toList();
      listIDSelectedFriend = <String>[infoConversation.id];
    } else if (infoConversation is Conversation) {
      // get list id of users in current conversation
      final List<String> listIDUserInConversation = (infoConversation as Conversation).listUserIn.map((e) => e.id).toList();
      // show list friend with condition have not
      // id of friends in listIDUserInConversation
      listFriend = List.from(userRepository.listFriend).where((element) => !listIDUserInConversation.contains(element.id)).map((e) {
        return {
          "user": e,
          "beSelected": false,
        };
      }).toList();
    }
    listSearchFriend.value = List.from(listFriend);
  }

  void onChangeTextFieldFind(String value) {
    listSearchFriend.value = List.from(listFriend.where((element) => element["user"].name.toLowerCase().contains(value.toLowerCase())));
  }

  Future<void> openBottomSheet() async {
    await showModalBottomSheet(
      context: Get.context,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddGroupBottomSheet(
          menuChatController: this,
        );
      },
    );
  }

  void onTapSelectFriend(User selectedFriend) {
    final int index = listFriend.indexWhere((element) => element["user"].id == selectedFriend.id);
    final int indexInListSearch = listSearchFriend.indexWhere((element) => element["user"].id == selectedFriend.id);
    listFriend[index] = <String, dynamic>{
      "user": listFriend[index]["user"],
      "beSelected": !listFriend[index]["beSelected"],
    };
    listSearchFriend[indexInListSearch] = listFriend[index];
    if (listFriend[index]["beSelected"]) {
      listIDSelectedFriend.add(selectedFriend.id);
    } else {
      listIDSelectedFriend.removeWhere((element) => element == selectedFriend.id);
    }
  }

  Future<void> onTapCreateButton() async {
    // await conversationRepository.getListConversationAndRoom();
    if (listIDSelectedFriend.length < 2) {
      Timer _timer;
      await showDialog(
        context: Get.context,
        builder: (BuildContext builderContext) {
          _timer = Timer(Duration(milliseconds: 600), () {
            Get.back();
          });

          return  AlertDialog(
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
                  size: ScreenUtil().setSp(30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Vui lòng chọn bạn để tạo nhóm chat!",
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    color: Palette.zodiacBlue,
                    // fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(15),
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ).then((val){
        if (_timer.isActive) {
          _timer.cancel();
        }
      });
    } else {
      socketController.emitSendCreateRoom(listIDSelectedFriend, nameEditingController.text);

      // Get.toNamed(GetRouter.chat, arguments: [index, true]);
    }
    // Get.offNamedUntil(GetRouter.home, ModalRoute.withName(GetRouter.drawer));
  }

  void onTapCancelButton() {
    findEditingController.clear();
    listFriend = listFriend.map((e) => {
      "user": e["user"],
      "beSelected": false,
    },).toList();
    listSearchFriend.value = listFriend;
    Get.back();
  }
}