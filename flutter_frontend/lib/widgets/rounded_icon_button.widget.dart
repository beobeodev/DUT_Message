import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';

class RoundedIconButton extends StatelessWidget {
  final double size;
  final double iconSize;

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final void Function() onPressed;

  const RoundedIconButton({
    Key? key,
    this.size = 50,
    this.iconSize = 21,
    required this.icon,
    this.iconColor = Colors.white,
    this.backgroundColor = Palette.red200,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        fixedSize: Size(size, size),
        minimumSize: Size(size, size),
        shape: const CircleBorder(),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
