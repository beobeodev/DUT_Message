import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enums/message_type.enum.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConversationItem extends GetView<HomeController> {
  final ConversationModel currentConversation;
  final void Function() onTap;

  const ConversationItem({
    Key? key,
    required this.currentConversation,
    required this.onTap,
  }) : super(key: key);

  String getConversationAvatar() {
    final UserModel friend = currentConversation.userIns.firstWhere(
      (element) => controller.authController.currentUser!.id != element.id,
    );
    String conversationAvatar = friend.avatar;
    if (currentConversation.isRoom) {
      conversationAvatar = currentConversation.avatarRoom;
    }
    return conversationAvatar;
  }

  String getConversationName() {
    final UserModel friend = currentConversation.userIns.firstWhere(
      (element) => controller.authController.currentUser!.id != element.id,
    );

    String conversationName = friend.name;

    if (currentConversation.isRoom) {
      conversationName = currentConversation.name;
    }

    return conversationName;
  }

  String getLastContentMessage() {
    final MessageModel lastMessage = currentConversation.lastMessage;

    String lastText = 'Bạn: ${lastMessage.realContent}';
    if (lastMessage.author.id == controller.authController.currentUser!.id) {
      if (lastMessage.messageType != MessageType.text) {
        lastText = 'Bạn đã gửi một tệp đính kèm';
      } else if (currentConversation.messageLength == 1 &&
          currentConversation.isRoom) {
        lastText = 'Bạn đã tạo nhóm này';
      } else if (lastMessage.deleted) {
        lastText = 'Bạn đã gỡ một tin nhắn';
      } else {
        lastText = 'Bạn: ${lastMessage.realContent}';
      }
    } else {
      if (currentConversation.isRoom) {
        if (lastMessage.messageType != MessageType.text) {
          lastText = '${lastMessage.author.name}: đã gửi một tệp đính kèm';
        } else if (currentConversation.messageLength == 1) {
          lastText = '${lastMessage.author.name} đã tạo nhóm này';
        } else if (lastMessage.deleted) {
          lastText = '${lastMessage.author.name}: đã gỡ một tin nhắn';
        } else {
          lastText = '${lastMessage.author.name}: ${lastMessage.realContent}';
        }
      } else {
        if (lastMessage.messageType != MessageType.text) {
          lastText = 'Đã gửi một tệp đính kèm';
        } else {
          lastText = lastMessage.realContent;
        }
      }
    }

    return lastText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 65.h,
        padding: const EdgeInsets.only(
          left: 15,
          top: 5,
          bottom: 5,
        ),
        margin: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(getConversationAvatar()),
            ),
            const SizedBox(
              width: 18,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getConversationName(),
                    style: TextStyle(
                      color: Palette.zodiacBlue,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.fontNunito,
                      fontSize: ScreenUtil().setSp(17),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    getLastContentMessage(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: currentConversation.lastMessage.author.id ==
                              controller.authController.currentUser!.id
                          ? Palette.gray300
                          : Palette.zodiacBlue,
                      fontWeight: currentConversation.lastMessage.author.id ==
                              controller.authController.currentUser!.id
                          ? FontWeight.w400
                          : FontWeight.w700,
                      fontFamily: FontFamily.fontNunito,
                      fontSize: 15.sp,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
