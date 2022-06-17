import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusMenu extends StatelessWidget {
  final double menuWidth;
  final double menuHeight;
  final double leftMargin;
  final double topMargin;
  final List<Widget> focusMenuItems;

  const FocusMenu({
    Key? key,
    this.menuWidth = 200,
    this.menuHeight = 100,
    required this.leftMargin,
    required this.topMargin,
    required this.focusMenuItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
          ),
          Positioned(
            left: leftMargin,
            top: topMargin,
            child: Container(
              width: menuWidth,
              height: focusMenuItems.length * 50.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Column(
                  children: focusMenuItems,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
