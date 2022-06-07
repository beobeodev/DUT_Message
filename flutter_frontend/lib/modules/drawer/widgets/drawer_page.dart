import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/drawer/controllers/drawer_screen_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/drawer/widgets/drawer_menu_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DrawerPage extends StatelessWidget {
  final DrawerScreenController drawerController =
      Get.put(DrawerScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(drawerController.currentUser.avatar),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                drawerController.currentUser.name,
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
              itemCount: drawerController.listMenuItem.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: GestureDetector(
                    onTap: () {
                      drawerController.onTapMenuItem(drawerController
                          .listMenuItem[index]['icon'] as IconData);
                    },
                    child: DrawerMenuItem(
                      title: drawerController.listMenuItem[index]['title']
                          as String,
                      icon: drawerController.listMenuItem[index]['icon']
                          as IconData,
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        backgroundColor: Palette.blue,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: drawerController.onPressFacebookButton,
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: ScreenUtil().setWidth(size.width - 140),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.cog,
                                color: Palette.zodiacBlue,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Cài đặt",
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
                            onTap: drawerController.onTapLogoutButton,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Đăng xuất",
                                  style: TextStyle(
                                    fontFamily: FontFamily.fontNunito,
                                    color: Palette.zodiacBlue,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  FontAwesomeIcons.signOutAlt,
                                  color: Palette.zodiacBlue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
