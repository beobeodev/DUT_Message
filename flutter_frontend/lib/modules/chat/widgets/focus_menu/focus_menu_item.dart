import 'package:flutter/material.dart';

class FocusMenuItem extends StatelessWidget {
  final Text title;
  final Icon icon;
  final dynamic Function() onTapItem;

  const FocusMenuItem({Key key,@required this.title,@required this.icon,@required this.onTapItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 1),
        color: Colors.white,
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              title,
              icon
            ],
          ),
        ),
      ),
    );
  }
}
