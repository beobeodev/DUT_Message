import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/home/widgets/header_home.widget.dart';
import 'package:flutter_frontend/modules/home/widgets/list_conversation.widget.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const HeaderHome(),
          Positioned(
            top: size.height * 0.14,
            right: 0,
            width: 0.3 * size.width,
            height: 0.2 * size.height,
            child: const ColoredBox(
              color: Palette.blue200,
            ),
          ),
          const ListConversation(),
        ],
      ),
      backgroundColor: Palette.gray200,
    );
  }
}
