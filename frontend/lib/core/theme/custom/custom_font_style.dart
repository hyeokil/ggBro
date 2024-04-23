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
  static const huge = TextStyle(
    fontFamily: "CuteFont",
    color: AppColors.black,
    fontSize: 400,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const huge1 = TextStyle(
    fontFamily: "YeonSung",
    color: AppColors.black,
    fontSize: 400,
    fontWeight: CustomFontWeight.semiBold,
  );

}
