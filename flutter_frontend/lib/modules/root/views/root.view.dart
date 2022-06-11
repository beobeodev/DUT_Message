import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_frontend/modules/root/widgets/build_page.dart';
import 'package:flutter_frontend/modules/root/widgets/drawer_side.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  final RootController rootController =
      Get.put(RootController(authController: Get.find<AuthController>()));

  RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(143, 169, 236, 0.6),
              Color.fromRGBO(239, 65, 65, 0.15),
            ],
          ),
        ),
        child: Stack(
          children: const [
            DrawerSide(),
            BuildPage(),
          ],
        ),
      ),
    );
  }
}
