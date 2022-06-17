import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoundedAlertDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String content;

  const RoundedAlertDialog({
    Key? key,
    required this.icon,
    this.iconColor = Colors.green,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: Get.width / 2,
        height: Get.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 60.sp,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              content,
              style: TextStyle(
                fontFamily: FontFamily.fontNunito,
                color: Palette.zodiacBlue,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
