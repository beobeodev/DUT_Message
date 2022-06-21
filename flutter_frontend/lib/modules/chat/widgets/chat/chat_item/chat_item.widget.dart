import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enums/message_type.enum.dart';
import 'package:flutter_frontend/core/utils/extensions/date_time_format.extension.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/chat_item/chat_item_content.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatItem extends GetView<ChatController> {
  final bool isSender;
  final bool isRoomConversation;
  final MessageModel message;
  final GlobalKey testKey = GlobalKey();

  ChatItem({
    Key? key,
    required this.isSender,
    required this.isRoomConversation,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isSender)
          Text(
            message.timeSend.toHourAndMinute,
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(12),
              fontFamily: FontFamily.fontNunito,
              fontWeight: FontWeight.w400,
            ),
          )
        else
          CircleAvatar(
            radius: ScreenUtil().setWidth(13),
            backgroundImage: NetworkImage(
              message.author.avatar,
            ),
          ),
        Flexible(
          child: GestureDetector(
            key: testKey,
            onLongPress: () {
              if (!message.deleted) {
                controller.onOpenFocusMenu(
                  testKey,
                  isFile:
                      message.messageType == MessageType.text ? false : true,
                  isSender: isSender,
                  urlDownload: message.realContent,
                  messageId: message.id,
                );
              }
            },
            child: ChatItemContent(
              message: message,
              isSender: isSender,
              isRoomConversation: isRoomConversation,
            ),
          ),
        ),
        if (!isSender)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              message.timeSend.toHourAndMinute,
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
