import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';

abstract class TextStyles {
  //* Bold text
  static const TextStyle largeBoldText = TextStyle(
    fontFamily: FontFamily.fontNunito,
    color: Palette.zodiacBlue,
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );

  static const TextStyle mediumBoldText = TextStyle(
    fontFamily: FontFamily.fontNunito,
    color: Palette.zodiacBlue,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  //* Regular text
  static const TextStyle largeRegularText = TextStyle(
    fontFamily: FontFamily.fontNunito,
    color: Palette.zodiacBlue,
    fontWeight: FontWeight.w400,
    fontSize: 17,
  );

  static const TextStyle mediumRegularText = TextStyle(
    fontFamily: FontFamily.fontNunito,
    color: Palette.zodiacBlue,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
