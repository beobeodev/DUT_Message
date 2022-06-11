import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatItemContent extends StatelessWidget {
  final Message message;
  final bool isSender;
  final bool isRoomConversation;

  const ChatItemContent({
    Key? key,
    required this.message,
    required this.isSender,
    required this.isRoomConversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.isImage && !message.isDeleted) {
      if (message.content.contains('/o/images%')) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isRoomConversation && !isSender)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15),
                child: Text(
                  message.author.name,
                  style: const TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontSize: 13,
                    color: Palette.zodiacBlue,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: CachedNetworkImage(
                imageUrl: message.content,
                placeholder: (context, url) {
                  return SizedBox(
                    width: ScreenUtil().screenWidth / 2 + 40,
                    height: 60,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: ScreenUtil().screenWidth / 2 + 40,
              ),
            ),
          ],
        );
      } else if (message.content.contains('/o/files%')) {
        return Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: (isRoomConversation && !isSender) ? 2 : 10,
          ),
          width: 250,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 18,
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
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.fileAlt,
                color: Palette.zodiacBlue,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  RegExp(r'(?<=files\/)(.*)(?=.(\\?alt=))')
                      .firstMatch(Uri.decodeFull(message.content))!
                      .group(0)!,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(17),
                    fontFamily: FontFamily.fontNunito,
                    overflow: TextOverflow.ellipsis,
                    color: isSender ? Colors.white : Palette.zodiacBlue,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRoomConversation && !isSender)
            Text(
              message.author.name,
              style: const TextStyle(
                fontFamily: FontFamily.fontNunito,
                fontSize: 13,
                color: Palette.zodiacBlue,
              ),
            ),
          Container(
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
                fontSize: ScreenUtil().setSp(17),
                fontFamily: FontFamily.fontNunito,
                color: message.isDeleted
                    ? Colors.white
                    : (isSender ? Colors.white : Palette.zodiacBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
