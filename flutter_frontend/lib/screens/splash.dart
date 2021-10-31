import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/splash/splash_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/splash/dut_message_logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Palette.darkAliceBlue,
              Colors.white,
            ],
          ),
        ),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + ScreenUtil().setHeight(20),
            ),
            child: Stack(
              children: [
                Align(
                  child: Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImagePath.dutLogo,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: SizedBox(
                          width: ScreenUtil().setWidth(60),
                          height: ScreenUtil().setWidth(60),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Text(
                        "Trường Đại học Bách Khoa\nĐại học Đà Nẵng",
                        style: TextStyle(
                          color: Palette.metallicViolet,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.fontNunito,
                          fontSize: ScreenUtil().setSp(24),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                DUTMessageLogo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


