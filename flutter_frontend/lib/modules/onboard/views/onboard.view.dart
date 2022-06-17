import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/text_styles.dart';
import 'package:flutter_frontend/generated/locales.g.dart';
import 'package:flutter_frontend/modules/onboard/controllers/onboard.controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/onboard/widgets/onboard_page_item.widget.dart';
import 'package:flutter_frontend/modules/onboard/widgets/row_arrow_button.widget.dart';
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
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    fixedSize: Size(110.w, 40.h),
                    minimumSize: Size(110.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Palette.red200,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        LocaleKeys.text_skip.tr,
                        style: TextStyles.largeBoldText
                            .copyWith(color: Colors.white),
                      ),
                      const Icon(
                        FontAwesomeIcons.arrowRight,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40.h,
              // ),
              Expanded(
                child: PageView.builder(
                  itemCount: controller.pageData.length,
                  onPageChanged: controller.onPageChange,
                  controller: controller.pageController,
                  itemBuilder: (context, index) {
                    return OnboardPageItem(
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
              const RowArrowButton()
            ],
          ),
        ),
      ),
    );
  }
}
