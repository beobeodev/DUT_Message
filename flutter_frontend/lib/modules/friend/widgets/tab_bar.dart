import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TabNavigationBar extends GetView<FriendController> {
  const TabNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 8,
            offset: Offset(2, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      width: double.infinity,
      height: 50.h,
      child: Row(
        children: List.generate(2, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPressTab(index);
              },
              child: Obx(
                () => AnimatedContainer(
                  decoration: BoxDecoration(
                    color: controller.currentTabIndex.value == index
                        ? Palette.blue300
                        : Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  height: double.infinity,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Text(
                      index == 0 ? 'Danh sách' : 'Kết bạn',
                      style: TextStyle(
                        color: controller.currentTabIndex.value != index
                            ? Palette.blue300
                            : Colors.white,
                        fontSize: ScreenUtil().setSp(17),
                        fontFamily: FontFamily.fontNunito,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
