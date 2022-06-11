import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsFriendContent extends StatelessWidget {
  final void Function() onPressButtonChat;
  final void Function() onTapButtonCancelFriend;

  const IsFriendContent({
    Key? key,
    required this.onPressButtonChat,
    required this.onTapButtonCancelFriend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
      child: Column(
        children: [
          Text(
            'Hiện đang là bạn bè',
            style: TextStyle(
              fontFamily: FontFamily.fontNunito,
              color: Palette.zodiacBlue,
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Palette.red100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                onPressed: onTapButtonCancelFriend,
                child: Text(
                  'Huỷ kết bạn',
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color(0xFF3570EC),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                onPressed: onPressButtonChat,
                child: Text(
                  'Nhắn tin',
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
