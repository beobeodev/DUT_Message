import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/chat/chat_controller.dart';
import 'package:flutter_frontend/controller/drawer/drawer_controller.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/widgets/chat/app_bar.dart';
import 'package:flutter_frontend/widgets/chat/bottom_chat.dart';
import 'package:flutter_frontend/widgets/chat/chat_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final HomeController homeController = Get.put(HomeController());

  final DrawerScreenController drawerController = Get.put(DrawerScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarChat(
            chatController: chatController,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: chatController.scrollController,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                itemCount: chatController.currentConversation.value.listMessage.length,
                itemBuilder: (context, index) {
                  final Message currentMessage = chatController.currentConversation.value.listMessage[index];
                  final bool isSender = currentMessage.author.id == drawerController.currentUser.id;
                  if (chatController.isRoom && index == 0) {
                    return Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          homeController.currentUser.id
                          == currentMessage.author.id
                          ? "Bạn đã tạo nhóm này"
                          : currentMessage.content,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(13),
                            color: Palette.zodiacBlue,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ChatItem(
                      isSender: isSender,
                      time: "${currentMessage.timeSend.hour.toString()} "
                          ": ${currentMessage.timeSend.minute.toString()}",
                      content: currentMessage.content,
                      isImage: currentMessage.isImage,
                      avatar: currentMessage.author.avatar,
                      authorName: currentMessage.author.name,
                      isRoom: chatController.isRoom,
                    );
                  }
                },
              ),
            ),
          ),
          BottomChat(
            chatController: chatController,
          )
        ],
      ),
      backgroundColor: Palette.lavenderSilver,
    );
  }
}
