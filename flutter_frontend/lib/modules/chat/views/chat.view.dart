import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat.controller.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/app_bar_chat.widget.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/bottom_chat.widget.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/chat_item/chat_item.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            AppBarChat(
              chatController: controller,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: controller.messageScrollController,
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  itemCount: controller.currentConversation.messages.length,
                  itemBuilder: (context, index) {
                    final MessageModel currentMessage =
                        controller.currentConversation.messages[index];
                    final bool isSender = currentMessage.author.id ==
                        controller.authController.currentUser!.id;

                    if (controller.isRoomConversation &&
                        currentMessage.isNotify &&
                        index == 0) {
                      return Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            controller.authController.currentUser!.id ==
                                    currentMessage.author.id
                                ? 'Bạn đã tạo nhóm này'
                                : currentMessage.realContent,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Palette.zodiacBlue,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ChatItem(
                        isSender: isSender,
                        isRoomConversation: controller.isRoomConversation,
                        message: currentMessage,
                      );
                    }
                  },
                ),
              ),
            ),
            const BottomChat()
          ],
        ),
        backgroundColor: Palette.lavenderSilver,
      ),
    );
  }
}
