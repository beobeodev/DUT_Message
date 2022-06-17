import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileContent extends StatelessWidget {
  final MessageModel message;
  final bool isSender;

  const FileContent({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   left: 10,
      //   right: 10,
      //   top: (isRoomConversation && !isSender) ? 2 : 10,
      // ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: isSender ? Palette.blue300 : Colors.white,
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
      child: Wrap(
        children: [
          Icon(
            FontAwesomeIcons.fileAlt,
            color: isSender ? Colors.white : Palette.zodiacBlue,
            size: 21.sp,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            RegExp(r'(?<=files\/)(.*)(?=.(\\?alt=))')
                .firstMatch(Uri.decodeFull(message.realContent))!
                .group(0)!,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              fontFamily: FontFamily.fontNunito,
              overflow: TextOverflow.ellipsis,
              color: isSender ? Colors.white : Palette.zodiacBlue,
            ),
          ),
        ],
      ),
    );
  }
}
