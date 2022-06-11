import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarChat extends StatelessWidget {
  const AppBarChat({Key? key, required this.chatController}) : super(key: key);

  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SizedBox(
        height: 65 + MediaQuery.of(context).padding.top,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: ScreenUtil().setHeight(10),
            right: ScreenUtil().setWidth(10),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: chatController.onTapBackIcon,
                icon: const Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Palette.red200,
                ),
                iconSize: ScreenUtil().setSp(23),
              ),
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     color: Colors.red,
              //     borderRadius: BorderRadius.circular(60),
              //   ),
              //   child: SizedBox(
              //     width: ScreenUtil().setWidth(45),
              //     height: ScreenUtil().setWidth(45),
              //   ),
              // ),
              GestureDetector(
                onTap: chatController.openMenuChatScreen,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: chatController.isRoomConversation
                          ? NetworkImage(
                              chatController.currentConversation.avatarRoom,
                            )
                          : NetworkImage(chatController.friendUser.avatar),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Text(
                      chatController.isRoomConversation
                          ? chatController.currentConversation.name
                          : chatController.friendUser.name,
                      style: TextStyle(
                        fontFamily: FontFamily.fontNunito,
                        color: Palette.zodiacBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     FontAwesomeIcons.video,
              //     color: Palette.orangeRed,
              //   ),
              //   iconSize: ScreenUtil().setSp(24),
              // ),
              // SizedBox(
              //   width: ScreenUtil().setWidth(8),
              // ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     FontAwesomeIcons.phoneAlt,
              //     color: Palette.orangeRed,
              //   ),
              //   iconSize: ScreenUtil().setSp(21),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
