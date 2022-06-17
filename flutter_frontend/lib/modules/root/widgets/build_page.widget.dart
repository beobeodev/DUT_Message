import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/friend/views/friend.view.dart';
import 'package:flutter_frontend/modules/home/views/home.view.dart';
import 'package:flutter_frontend/modules/profile/views/profile.view.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class BuildPage extends GetView<RootController> {
  const BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: controller.closeDrawer,
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCirc,
            transform: Matrix4.translationValues(
              controller.xOffset.value,
              controller.yOffset.value,
              0,
            )..scale(controller.scaleFactor.value),
            child: AbsorbPointer(
              absorbing: controller.isDrawerOpen.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  controller.isDrawerOpen.value ? 40 : 0,
                ),
                child: IndexedStack(
                  index: controller.currentIndexPage.value,
                  children: const [
                    HomeScreen(),
                    FriendScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
