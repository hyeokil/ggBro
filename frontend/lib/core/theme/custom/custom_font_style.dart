import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomFontStyle {
  static TextStyle getTextStyle(BuildContext context, TextStyle baseStyle) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = width / 1480;
    return baseStyle.copyWith(fontSize: baseStyle.fontSize! * scaleFactor);
  }

  /// Typography
  static const cuteFont = TextStyle(
    fontFamily: "CuteFont",
    fontSize: 50,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const yeonSung = TextStyle(
    fontFamily: "YeonSung",
    fontSize: 50,
    fontWeight: CustomFontWeight.semiBold,
  );

}
