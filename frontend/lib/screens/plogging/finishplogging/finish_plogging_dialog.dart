import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/plogging/finishplogging/component/finish_clear_monster_content.dart';
import 'package:frontend/screens/plogging/finishplogging/component/finish_clear_monster_title.dart';
import 'package:go_router/go_router.dart';

class FinishPloggingDialog extends StatefulWidget {
  const FinishPloggingDialog({super.key});

  @override
  State<FinishPloggingDialog> createState() => _FinishPloggingDialogState();
}

class _FinishPloggingDialogState extends State<FinishPloggingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 자치 안하게
        children: [
          Container(
            // color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.37,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FinishClearMonsterTitle(),
                FinishClearMonsterContent(
                  color: AppColors.basicpink,
                  content: '플라몽',
                ),
                FinishClearMonsterContent(
                  color: AppColors.basicgray,
                  content: '포 캔몽',
                ),
                FinishClearMonsterContent(
                  color: AppColors.basicgreen,
                  content: '율몽',
                ),
                FinishClearMonsterContent(
                  color: AppColors.basicnavy,
                  content: '미쪼몬',
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: AppColors.readyButton,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 3, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.basicgray.withOpacity(0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '확 인',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung80_white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // actions: <Widget>[
        // GreenButton(
        //   "취소",
        //   onPressed: () => Navigator.of(context).pop(), // 모달 닫기
        // ),
      // ],
    );
  }
}
