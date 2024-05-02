import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class FinishClearMonsterTitle extends StatefulWidget {
  const FinishClearMonsterTitle({super.key});

  @override
  State<FinishClearMonsterTitle> createState() => _FinishClearMonsterTitleState();
}

class _FinishClearMonsterTitleState extends State<FinishClearMonsterTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: Offset(0, 4),
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            '오전 11 : 00 ~ 오후 12 : 00',
            style:
                CustomFontStyle.getTextStyle(context, CustomFontStyle.yeonSung70),
          ),
        ],
      ),
    );
  }
}
