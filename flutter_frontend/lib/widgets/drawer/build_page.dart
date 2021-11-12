import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  const BuildPage({Key key, this.isDrawerOpen, this.xOffset, this.yOffset, this.scaleFactor, this.pageItem, this.closeDrawer}) : super(key: key);

  final bool isDrawerOpen;
  final double xOffset;
  final double yOffset;
  final double scaleFactor;
  final Widget pageItem;
  final void Function() closeDrawer;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: closeDrawer,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
              child: pageItem,
            ),
          ),
        ),
      )
    );
  }
}
