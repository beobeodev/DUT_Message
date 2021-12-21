import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusMenuDetail extends StatelessWidget {
  final double menuWidth;
  final double menuHeight;
  final double leftMargin;
  final double topMargin;
  final List<Widget> listFocusMenuItem;

  const FocusMenuDetail({Key key, this.menuWidth = 200, this.menuHeight = 100, @required this.leftMargin, @required this.topMargin, @required this.listFocusMenuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
              height: listFocusMenuItem.length * 50.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: 1)],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: ListView.builder(
                  itemCount: listFocusMenuItem.length,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return listFocusMenuItem[index];
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
