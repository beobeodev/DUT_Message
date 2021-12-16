import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildWideSocial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
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
            width: double.infinity,
            height: ScreenUtil().setHeight(55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  ImagePath.goolgeIcon,
                  width: 40,
                  height: 40,
                ),
                Text(
                  "Login with Google",
                  style: TextStyle(
                    color: Palette.sweetRed,
                    fontFamily: FontFamily.fontPoppins,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(18),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Palette.crayolaBlue,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                  size: 38,
                ),
                Text(
                  "Login with Facebook",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.fontPoppins,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(18),
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
