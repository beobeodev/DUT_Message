import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/widgets/loading_dot.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  final void Function() onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final String content;
  final bool isLoading;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50,
    this.fontSize = 20,
    this.borderRadius = 10,
    this.backgroundColor = Palette.red100,
    this.textColor = Colors.white,
    required this.content,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(width, height),
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
      ),
      child: isLoading
          ? const LoadingDot()
          : Text(
              content,
              style: TextStyle(
                fontFamily: FontFamily.fontNunito,
                color: textColor,
                fontWeight: FontWeight.w700,
                fontSize: fontSize.sp,
              ),
            ),
    );
  }
}
