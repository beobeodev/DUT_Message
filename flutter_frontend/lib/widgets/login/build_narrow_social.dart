import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/config/constants/font_family.dart';
import 'package:flutter_frontend/config/constants/image_path.dart';
import 'package:flutter_frontend/config/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildNarrowSocial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Palette.sweetRed,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SizedBox(
            width: (ScreenUtil().screenWidth - ScreenUtil().setWidth(25.0)*2)/2 - 10,
            height: ScreenUtil().setHeight(55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  ImagePath.goolgeIcon,
                ),
                Text(
                  "Login with Google",
                  style: TextStyle(
                    color: Palette.sweetRed,
                    fontFamily: FontFamily.fontPoppins,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(13),
                  ),
                )
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Palette.crayolaBlue,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SizedBox(
            width: (ScreenUtil().screenWidth - ScreenUtil().setWidth(25.0)*2)/2 - 10,
            height: ScreenUtil().setHeight(55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  "Login with Facebook",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.fontPoppins,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(13),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
