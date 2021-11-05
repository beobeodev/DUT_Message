import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBarChat() {
    return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        BackButton(),
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
          width: 50,
          height: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quốc Đạt",
              style: TextStyle(
                fontFamily: FontFamily.fontNunito,
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtil().setSp(18),
                color: Palette.zodiacBlue,
              ),
            ),

          ],
        )
      ],
    ),
  );
}
