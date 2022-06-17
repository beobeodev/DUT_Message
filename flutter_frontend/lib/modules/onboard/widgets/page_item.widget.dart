import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class PageItem extends StatelessWidget {
  const PageItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          imagePath,
          width: double.infinity,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(40),
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: FontFamily.fontPoppins,
            fontWeight: FontWeight.w700,
            color: Palette.zodiacBlue,
            fontSize: ScreenUtil().setSp(22),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Text(
          content,
          style: TextStyle(
            fontFamily: FontFamily.fontNunito,
            fontWeight: FontWeight.w700,
            color: Palette.zodiacBlue,
            fontSize: ScreenUtil().setSp(18),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
