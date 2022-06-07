import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        // border: Border.all(
        //   color: Color(0xFFFF2442),
        // ),
      ),
      child: SizedBox(
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: FontFamily.fontNunito,
                color: Palette.sweetRed,
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              icon,
              color: Palette.sweetRed,
            ),
          ],
        ),
      ),
    );
  }
}
