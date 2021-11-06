import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({this.isSender, this.time, this.message});

  //check sender is current user or others
  final bool isSender;
  final String time;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isSender) Text(
          time,
          style: TextStyle(
            color: Palette.americanSilver,
            fontSize: ScreenUtil().setSp(18),
            fontFamily: FontFamily.fontNunito,
            fontWeight: FontWeight.w400,
          ),
        ) else DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: SizedBox(
            width: ScreenUtil().setWidth(40),
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.all(20),
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
              message,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ScreenUtil().setSp(20),
                fontFamily: FontFamily.fontNunito,
                color: isSender ? Colors.white : Palette.zodiacBlue,
              ),
            ),
          ),
        ),
        if (isSender) SizedBox() else Text(
          time,
          style: TextStyle(
            color: Palette.americanSilver,
            fontSize: ScreenUtil().setSp(18),
            fontFamily: FontFamily.fontNunito,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
