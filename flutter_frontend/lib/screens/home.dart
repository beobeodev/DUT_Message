import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/home/header_home.dart';
import 'package:flutter_frontend/widgets/home/list_message.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          HeaderHome(),
          Positioned(
            top: size.height * 0.29,
            right: 0,
            width: 0.3 * size.width,
            height: 0.5 * size.height,
            child: ColoredBox(
              color: Palette.crayolaBlue,
            ),
          ),
          ListMessage(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

