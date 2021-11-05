import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SizedBox(
        height: 65 + MediaQuery.of(context).padding.top,
        child: Padding(
          padding:  EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: ScreenUtil().setHeight(10),
            right: ScreenUtil().setWidth(10),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Palette.orangeRed,
                ),
                iconSize: ScreenUtil().setSp(23),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: SizedBox(
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quốc Đạt",
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      color: Palette.zodiacBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                  Text(
                    "Hoạt động 5 phút trước",
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      color: Palette.americanSilver,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.video,
                  color: Palette.orangeRed,
                ),
                iconSize: ScreenUtil().setSp(24),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(8),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.phoneAlt,
                  color: Palette.orangeRed,
                ),
                iconSize: ScreenUtil().setSp(21),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
