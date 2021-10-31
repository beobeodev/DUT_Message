import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class OnboardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setHeight(30),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.orangeRed,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SizedBox(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            color: Colors.white,
                            fontFamily: FontFamily.fontPoppins,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              Lottie.asset(
                ImagePath.chatLottie,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
