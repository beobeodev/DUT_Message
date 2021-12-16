import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/chat/controllers/chat_controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomChat extends StatelessWidget {
  final ChatController chatController;

  const BottomChat({Key key, this.chatController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ColoredBox(
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
    );
  }
}
