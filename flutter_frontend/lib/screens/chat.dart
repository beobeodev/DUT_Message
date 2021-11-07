import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/chat/chat_controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/chat/appbar.dart';
import 'package:flutter_frontend/widgets/chat/chat_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          AppBarChat(
            chatController: chatController,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.only(top: 0.0, left: 10, right: 16),
                children: [
                  ChatItem(
                    isSender: false,
                    time: '18:00',
                    message: 'Bạn push code lên chưa?',
                  ),
                  ChatItem(
                    isSender: true,
                    time: '18:00',
                    message: 'Đợi xí',
                  ),
                ],
              ),
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, top: 6, left: 15, right: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
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
                        hintText: 'Type your message...',
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
                        contentPadding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                      ),
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
