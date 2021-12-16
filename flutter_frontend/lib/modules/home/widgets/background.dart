import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';

class BackgroundHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          width: size.width,
          height: 0.3 * size.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Palette.crayolaBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.0),
              ),
            ),
          ),
        ),
        Positioned(
            top: size.height * 0.29,
            right: 0,
            width: 0.3 * size.width,
            height: 0.5 * size.height,
            child: ColoredBox(
              color: Palette.crayolaBlue,
            ),
        ),
        Positioned(
          top: size.height * 0.3,
          width: size.width,
          height: 0.7 * size.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(60.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
