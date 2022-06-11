import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat.controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomChat extends GetView<ChatController> {
  const BottomChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          top: 6,
          left: 15,
          right: 15,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // chatController.showSelectModalBottom
              },
              child: Icon(
                FontAwesomeIcons.plusCircle,
                color: Palette.red200,
                size: ScreenUtil().setSp(26),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập tin nhắn...',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[50]!),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                    left: 16,
                    top: 13,
                    bottom: 12,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 13,
                ),
                controller: controller.inputTextController,
              ),
            ),
            IconButton(
              onPressed: controller.onTapButtonSendMessage,
              icon: const Icon(
                FontAwesomeIcons.solidPaperPlane,
                color: Palette.red200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
