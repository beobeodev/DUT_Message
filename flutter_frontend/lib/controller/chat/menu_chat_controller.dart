import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/widgets/chat/add_group_bottom_sheet.dart';
import 'package:get/get.dart';

class MenuChatController extends GetxController {
  final UserRepository userRepository = UserRepository();


  final User friendUser = Get.arguments;

  final TextEditingController findEditingController = TextEditingController();

  final RxList<Map<String, dynamic>> listFriend = <Map<String, dynamic>>[].obs;
  final List<User> listSelectedFriend = <User>[];
  // final RxList<Map<String, dynamic>> listFilterFriend = <Map<String, dynamic>>[].obs;
  // final RxList<bool> listCheckSelectedFriend = <bool>[].obs;
  // final RxList<User> listSelectedFriend = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    listFriend.value = List.from(userRepository.listFriend).toList().where((element) => element.id != friendUser.id).map((e) {
      return {
        "user": e,
        "beSelected": false,
      };
    }).toList();
    // listFilterFriend.value = List.from(listFriend).toList();
    // listCheckSelectedFriend.value = List.filled(listFriend.length, false);
  }

  void onChangeTextFieldFind(String value) {
    // listFilterFriend.value = userRepository.listFriend.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
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
    listFriend[index] = <String, dynamic>{
      "user": listFriend[index]["user"],
      "beSelected": !listFriend[index]["beSelected"],
    };
    if (listFriend[index]["beSelected"]) {
      listSelectedFriend.add(selectedFriend);
    } else {
      listSelectedFriend.removeWhere((element) => element.id == selectedFriend.id);
    }
  }
}