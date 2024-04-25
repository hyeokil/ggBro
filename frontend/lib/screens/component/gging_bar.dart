import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class GgingBar extends StatefulWidget {
  const GgingBar({super.key});

  @override
  State<GgingBar> createState() => _GgingBarState();
}

class _GgingBarState extends State<GgingBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.height * 0.3,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: AppColors.basicnavy,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(width: 3, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: AppColors.basicgray.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Center(
            child: Text(
              '2222',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung90_white),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.04,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(color: Colors.white),
          ),
        )
      ],
    );
  }
}
