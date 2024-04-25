import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class QuestList extends StatefulWidget {
  const QuestList({super.key});

  @override
  State<QuestList> createState() => _QuestListState();
}

class _QuestListState extends State<QuestList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
          decoration: BoxDecoration(
            color: AppColors.basicgray,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                  color: AppColors.basicgray.withOpacity(0.5),
                  offset: Offset(0, 4),
                  blurRadius: 1,
                  spreadRadius: 1)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '수돌이랑 플로깅 진행하기',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
              Text(
                '10',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Image.asset(AppIcons.intersect,
                width: MediaQuery.of(context).size.width * 0.11),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.0155,
          right: MediaQuery.of(context).size.width * 0.022,
          child: Container(
            child: Image.asset(AppIcons.gging,
                width: MediaQuery.of(context).size.width * 0.06),
          ),
        ),
      ],
    );
  }
}
