import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/chat/chat_controller.dart';
import 'package:flutter_frontend/controller/drawer/drawer_controller.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/chat/appbar.dart';
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
                padding: EdgeInsets.only(left: 10, right: 16, bottom: 10),
                // itemCount: chatController.currentConversation.listMessage.length,
                itemCount: homeController.listConversation[chatController.indexConversation].listMessage.length,
                itemBuilder: (context, index) {
                  final bool isSender = homeController.listConversation[chatController.indexConversation].listMessage[index].author.id ==
                      drawerController.currentUser.id;
                  return ChatItem(
                    isSender: isSender,
                    time: "${homeController.listConversation[chatController.indexConversation]
                        .listMessage[index].timeSend.hour
                        .toString()} : ${homeController.listConversation[chatController.indexConversation].listMessage[index].timeSend.minute
                        .toString()}",
                    message: homeController.listConversation[chatController.indexConversation]
                        .listMessage[index].content,
                    isImage: homeController.listConversation[chatController.indexConversation]
                        .listMessage[index].isImage,
                  );
                },
              ),
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0, top: 6, left: 15, right: 15,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: chatController.showSelectModalBottom,
                    child: Icon(
                      FontAwesomeIcons.plusCircle,
                      color: Palette.orangeRed,
                      size: ScreenUtil().setSp(26),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[50]),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[50]),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                            left: 16, top: 13, bottom: 12,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      controller: chatController.inputEditingController,
                    ),
                  ),
                  IconButton(
                    onPressed: chatController.onTapSendButton,
                    icon: Icon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: Palette.orangeRed,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Palette.lavenderSilver,
    );
  }
}
