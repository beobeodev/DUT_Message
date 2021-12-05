import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/chat/menu_chat_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuChatScreen extends StatelessWidget {
  final MenuChatController menuChatController = Get.put(MenuChatController());

  MenuChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 15, right: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Palette.crayolaBlue,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Align(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(menuChatController.friendUser.avatar),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Text(
              menuChatController.friendUser.name,
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
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                shape:  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              onPressed: menuChatController.openBottomSheet,
              child:  Row(
                children: [
                  Icon(
                    FontAwesomeIcons.userFriends,
                    color: Palette.zodiacBlue,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Tạo nhóm chat với ${menuChatController.friendUser.name}",
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      color: Palette.blue,
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
