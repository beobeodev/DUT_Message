import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HaveSendContent extends StatelessWidget {
  const HaveSendContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bạn đã gửi lời mời kết ',
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
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Palette.red100,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          onPressed: () {},
          child: Text(
            'Huỷ gửi',
            style: TextStyle(
              fontFamily: FontFamily.fontNunito,
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
        )
      ],
    );
  }
}
