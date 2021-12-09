import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/chat/chat_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatItem extends StatelessWidget {
  ChatItem({this.isSender, this.time, this.content, this.isImage = false, this.avatar, this.authorName, this.isRoom});

  //c heck sender is current user or others
  final bool isSender;
  // get time send message
  final String time;
  // get content of MESSAGE
  final String content;
  // check if message is image, video or file then show it
  final bool isImage;
  // get avatar of sender
  final String avatar;
  // get author name
  final String authorName;
  // check if conversation is group chat, show name of message's author
  final bool isRoom;

  final ChatController chatController = Get.put(ChatController());
  final GlobalKey testKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isSender) Text(
          time,
          style: TextStyle(
            color: Colors.black26,
            fontSize: ScreenUtil().setSp(12),
            fontFamily: FontFamily.fontNunito,
            fontWeight: FontWeight.w400,
          ),
        ) else CircleAvatar(
          radius: ScreenUtil().setWidth(13),
          backgroundImage: NetworkImage(
            avatar,
          ),
        ),
        Flexible(
          child: GestureDetector(
            key: testKey,
            onLongPress: () {
              chatController.onOpenFocusMenu(testKey);
            },
            child: isImage ? Padding(
              padding:  EdgeInsets.only(left: 10, top:  10),
              child: Image.network(
                content,
                width: ScreenUtil().screenWidth/2 + 50,
              ),
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isRoom && !isSender) Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15),
                  child: Text(
                    authorName,
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      fontSize: 13,
                      color: Palette.zodiacBlue,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: (isRoom && !isSender) ? 2 : 10),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: isSender ? Palette.blue : Colors.white,
                    borderRadius: isSender
                        ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                        : BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(17),
                      fontFamily: FontFamily.fontNunito,
                      color: isSender ? Colors.white : Palette.zodiacBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isSender) Text(
          time,
          style: TextStyle(
            color: Colors.black26,
            fontSize: ScreenUtil().setSp(12),
            fontFamily: FontFamily.fontNunito,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
