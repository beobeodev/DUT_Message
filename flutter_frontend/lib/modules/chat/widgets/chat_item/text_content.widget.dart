import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextContent extends StatelessWidget {
  final Message message;
  final bool isSender;

  const TextContent({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: message.isDeleted
            ? Palette.gray300
            : (isSender ? Palette.blue300 : Colors.white),
        borderRadius: isSender
            ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
      ),
      child: Text(
        message.isDeleted ? 'Đã gỡ tin nhắn' : message.content,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17.sp,
          fontFamily: FontFamily.fontNunito,
          color: message.isDeleted
              ? Colors.white
              : (isSender ? Colors.white : Palette.zodiacBlue),
        ),
      ),
    );
  }
}
