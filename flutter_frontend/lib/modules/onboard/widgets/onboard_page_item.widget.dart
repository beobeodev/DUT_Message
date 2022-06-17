import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnboardPageItem extends StatelessWidget {
  const OnboardPageItem({
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          imagePath,
          width: double.infinity,
        ),
        SizedBox(
          height: 40.h,
        ),
        Text(
          title,
          style: TextStyles.largeBoldText.copyWith(fontSize: 28.sp),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          content,
          style: TextStyles.largeBoldText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
