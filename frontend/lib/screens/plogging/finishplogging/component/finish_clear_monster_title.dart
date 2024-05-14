import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class FinishClearMonsterTitle extends StatefulWidget {
  final String time;
  const FinishClearMonsterTitle({super.key, required this.time});

  @override
  State<FinishClearMonsterTitle> createState() =>
      _FinishClearMonsterTitleState();
}

class _FinishClearMonsterTitleState extends State<FinishClearMonsterTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.basicgray.withOpacity(0.5),
            offset: const Offset(0, 4),
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
          Center(
            child: Text(
              widget.time,
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung70),
            ),
          ),
        ],
      ),
    );
  }
}
