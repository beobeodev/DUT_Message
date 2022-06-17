import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/onboard/controllers/onboard.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/onboard/widgets/page_item.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OnboardScreen extends GetView<OnboardController> {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 30.w,
            right: 30.w,
            bottom: 30.h,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.red200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: GestureDetector(
                    onTap: controller.onSkip,
                    child: SizedBox(
                      width: 100.w,
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 20.sp,
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
                  itemCount: controller.pageData.length,
                  onPageChanged: controller.onPageChange,
                  controller: controller.pageController,
                  itemBuilder: (context, index) {
                    return PageItem(
                      imagePath: controller.pageData[index]['imagePath']!,
                      title: controller.pageData[index]['title']!,
                      content: controller.pageData[index]['content']!,
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
                      opacity: controller.currentIndex.value == 0 ? 0 : 1,
                      child: GestureDetector(
                        onTap: controller.currentIndex.value == 0
                            ? () {}
                            : controller.onBackPage,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Palette.gray300,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SizedBox(
                            width: ScreenUtil().setWidth(50),
                            height: ScreenUtil().setWidth(50),
                            child: const Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: controller.currentIndex.value != 2
                          ? controller.onNextPage
                          : controller.onSkip,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Palette.red200,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SizedBox(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setWidth(50),
                          child: const Icon(
                            FontAwesomeIcons.arrowRight,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
