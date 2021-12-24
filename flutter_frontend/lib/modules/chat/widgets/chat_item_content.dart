import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatItemContent extends StatelessWidget {
  final bool isImage;
  final bool isRoom;
  final bool isSender;
  final bool isDeleted;
  final String content;
  final String authorName;

  const ChatItemContent({Key key,
    @required this.isImage,
    @required this.isRoom,
    @required this.isSender,
    @required this.content,
    @required this.authorName,
    @required this.isDeleted,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isImage && !isDeleted) {
      if (content.contains("/o/images%")) {
        return Padding(
          padding:  EdgeInsets.only(left: 10, top:  10),
          child: CachedNetworkImage(
            imageUrl: content,
            placeholder: (context, url) {
              return SizedBox(
                width: ScreenUtil().screenWidth/2 + 40,
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: ScreenUtil().screenWidth/2 + 40,
          ),
          // Image.network(
          //   content,
          //   width: ScreenUtil().screenWidth/2 + 50,
          // ),
        );
      } else if (content.contains("/o/files%")) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isRoom && !isSender) Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15),
              child: Text(
                authorName,
                style: TextStyle(
                  fontFamily: FontFamily.fontNunito,
                  fontSize: 13,
                  color: Palette.zodiacBlue,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: (isRoom && !isSender) ? 2 : 10),
              width: 250,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                color: isSender ? Palette.blue : Colors.white,
                borderRadius: isSender
                    ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ) : BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.fileAlt,
                    color: Palette.zodiacBlue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      RegExp(r"(?<=files\/)(.*)(?=.(\\?alt=))").firstMatch(Uri.decodeFull(content)).group(0),
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
            ),
          ],
        );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isRoom && !isSender) Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15),
          child: Text(
            authorName,
            style: TextStyle(
              fontFamily: FontFamily.fontNunito,
              fontSize: 13,
              color: Palette.zodiacBlue,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, top: (isRoom && !isSender) ? 2 : 10),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: isDeleted ? Palette.americanSilver : (isSender ? Palette.blue : Colors.white),
            borderRadius: isSender
                ? BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ) : BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Text(
            isDeleted ? "Đã gỡ tin nhắn" : content,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(17),
              fontFamily: FontFamily.fontNunito,
              color: isDeleted ? Colors.white : (isSender ? Colors.white : Palette.zodiacBlue),
            ),
          ),
        ),
      ],
    );
  }
}
