import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_frontend/modules/root/widgets/drawer_menu_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerSide extends GetView<RootController> {
  const DrawerSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(controller.currentUser.avatar),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                controller.currentUser.name,
                style: TextStyle(
                  fontFamily: FontFamily.fontNunito,
                  color: Palette.zodiacBlue,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            width: ScreenUtil().setWidth(150),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.listMenuItem.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: GestureDetector(
                    onTap: () {
                      controller.onTapMenuItem(
                        index,
                      );
                    },
                    child: DrawerMenuItem(
                      title: controller.listMenuItem[index]['title'] as String,
                      icon: controller.listMenuItem[index]['icon'] as IconData,
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: (Get.width - 120).w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Palette.zodiacBlue,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cài đặt',
                          style: TextStyle(
                            fontFamily: FontFamily.fontNunito,
                            color: Palette.zodiacBlue,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đăng xuất',
                            style: TextStyle(
                              fontFamily: FontFamily.fontNunito,
                              color: Palette.zodiacBlue,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.logout_outlined,
                            color: Palette.zodiacBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
