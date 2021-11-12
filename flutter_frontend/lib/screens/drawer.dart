import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/drawer/drawer_controller.dart';
import 'package:flutter_frontend/screens/home.dart';
import 'package:flutter_frontend/widgets/drawer/build_page.dart';
import 'package:flutter_frontend/widgets/drawer/drawer_page.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatelessWidget {
  final DrawerScreenController drawerController = Get.put(
      DrawerScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color.fromRGBO(143, 169, 236, 0.6),
              Color.fromRGBO(239, 65, 65, 0.15),
            ],
          ),
        ),
        child: Obx(() {
          return Stack(
            children: [
              DrawerPage(),
              BuildPage(
                isDrawerOpen: drawerController.isDrawerOpen.value,
                xOffset: drawerController.xOffset.value,
                yOffset: drawerController.yOffset.value,
                scaleFactor: drawerController.scaleFactor.value,
                closeDrawer: drawerController.closeDrawer,
                pageItem: HomeScreen(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
