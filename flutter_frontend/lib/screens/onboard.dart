import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/onboard/onboard_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/onboard/page_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OnboardScreen extends StatelessWidget {
  final OnboardController onboardController = Get.put(OnboardController());

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setHeight(30),
              bottom: ScreenUtil().setHeight(30),
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
                    child: GestureDetector(
                      onTap: onboardController.onSkip,
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
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: onboardController.pageData.length,
                    onPageChanged: onboardController.onPageChange,
                    controller: onboardController.pageController,
                    itemBuilder: (context, index) {
                      return PageItem(
                        imagePath: onboardController.pageData[index]['imagePath'],
                        title: onboardController.pageData[index]['title'],
                        content: onboardController.pageData[index]['content'],
                      );
                    },
                  ),
                ),
                // const Expanded(
                //   child: SizedBox(),
                // ),
                Obx(
                  () => Row(
                    children: [
                      Opacity(
                        opacity: onboardController.currentIndex.value == 0 ? 0 : 1,
                        child: GestureDetector(
                          onTap: onboardController.currentIndex.value == 0 ? () {} : onboardController.onBackPage,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Palette.americanSilver,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              width: ScreenUtil().setWidth(50),
                              height: ScreenUtil().setWidth(50),
                              child: Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox(),),
                      GestureDetector(
                        onTap: onboardController.currentIndex.value != 2 ? onboardController.onNextPage : onboardController.onSkip,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Palette.orangeRed,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SizedBox(
                            width: ScreenUtil().setWidth(50),
                            height: ScreenUtil().setWidth(50),
                            child: Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
          ),
        ),
      ),
    );
  }
}
