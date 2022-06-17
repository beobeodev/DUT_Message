import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/chat/controllers/menu_chat.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuChatScreen extends GetView<MenuChatController> {
  const MenuChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                padding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Palette.blue200,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Align(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  controller.isRoomConversation
                      ? controller.currentConversation.avatarRoom
                      : controller.friendUser.avatar,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Text(
              controller.isRoomConversation
                  ? controller.currentConversation.name
                  : controller.friendUser.name,
              style: TextStyle(
                fontFamily: FontFamily.fontNunito,
                color: Palette.zodiacBlue,
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtil().setSp(18),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (!controller.isRoomConversation)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                onPressed: controller.openBottomSheet,
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.userFriends,
                      color: Palette.zodiacBlue,
                      size: 20.sp,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Tạo nhóm chat với ${controller.friendUser.name}',
                      style: TextStyle(
                        fontFamily: FontFamily.fontNunito,
                        color: Palette.blue300,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      backgroundColor: Palette.lavenderSilver,
    );
  }
}
