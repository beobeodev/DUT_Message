import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/drawer/controllers/drawer_screen_controller.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend_controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/widgets/add_friend/add_friend_page.dart';
import 'package:flutter_frontend/modules/friend/widgets/friend_page/list_friend_page.dart';
import 'package:flutter_frontend/modules/friend/widgets/tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FriendScreen extends StatelessWidget {
  final FriendController friendController = Get.put(FriendController());
  final DrawerScreenController drawerController = Get.put(DrawerScreenController());

  @override
  Widget build(BuildContext context) {
    print("FRIEND SCREEN WAS BUILD");

    friendController.isOpenListTab.value = true;
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
              top: MediaQuery
                  .of(context)
                  .padding
                  .top + 20,
              left: 20,
              right: 20,
              bottom: 30,
            ),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: drawerController.openDrawer,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Palette.zodiacBlue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          FontAwesomeIcons.bars,
                          color: Colors.white,
                          size: ScreenUtil().setSp(15),
                        ),
                      ),
                    ),
                  ),
                  TabNavigationBar(
                    isOpenListTab: friendController.isOpenListTab.value,
                    onTapListTab: friendController.onTapListTab,
                    onTapAddTab: friendController.onTapAddTab,
                  ),
                  Expanded(
                    child: PageView(
                      controller: friendController.pageController,
                      onPageChanged: friendController.onPageChange,
                      children: [
                        ListFriendPage(friendController: friendController),
                        AddFriendPage(friendController: friendController),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
