import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FocusMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final dynamic Function() onTapItem;

  const FocusMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = Palette.red100,
    required this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Palette.zodiacBlue,
                fontFamily: FontFamily.fontNunito,
                fontSize: 13.sp,
              ),
            ),
            Icon(
              icon,
              color: iconColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
