import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat_item_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatItem extends StatelessWidget {
  ChatItem({
    this.isSender,
    this.time,
    this.content,
    this.isImage = false,
    this.avatar, this.authorName,
    this.isRoom,
    @required this.isDeleted,
    @required this.messageId,
  });

  //check sender is current user or others
  final bool isSender;
  // get time send message
  final String time;
  // get content of MESSAGE
  final String content;
  // check if message is image, video or file then show it
  final bool isImage;
  // check whether message have deleted
  final bool isDeleted;
  // get avatar of sender
  final String avatar;
  // get author name
  final String authorName;
  // check if conversation is group chat, show name of message's author
  final bool isRoom;
  // get message id
  final String messageId;

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
             if (!isDeleted) {
               chatController.onOpenFocusMenu(
                testKey,
                isFile: isImage,
                isSender: isSender,
                urlDownload: content,
                messageId: messageId,
              );
             }
            },
            child: ChatItemContent(
              isImage: isImage,
              isRoom: isRoom,
              isSender: isSender,
              content: content,
              authorName: authorName,
              isDeleted: isDeleted,
            ),
          ),
        ),
        if (!isSender) Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            time,
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(12),
              fontFamily: FontFamily.fontNunito,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
