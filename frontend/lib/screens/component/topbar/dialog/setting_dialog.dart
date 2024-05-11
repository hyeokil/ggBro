import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/tutorial/go_plogginG_tutorial_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingDialog extends StatefulWidget {
  final Function goTutorial;
  final Function goIntro;

  const SettingDialog({
    super.key,
    required this.goTutorial,
    required this.goIntro,
  });

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min, // 컬럼이 전체 다 자치 안하게
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  color: AppColors.basicpink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '설정',
                    style: CustomFontStyle.getTextStyle(
                      context,
                      CustomFontStyle.yeonSung80_white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEBF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.basicpink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      FontAwesomeIcons.circleXmark,
                      size: 41,
                      color: Color(0xFFEEEBF5),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.goTutorial();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.basicgray,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.basicgray.withOpacity(0.5),
                          offset: Offset(0, 4),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          // color: Colors.black,
                          child: Image.asset(AppIcons.earth_2)),
                      Text(
                        '튜토리얼',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung60_white),
                      ),
                      Text(
                        '다시 보기',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung60_white),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.goIntro();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.basicgray,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.basicgray.withOpacity(0.5),
                          offset: Offset(0, 4),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        // color: Colors.black,
                        child: Image.asset(AppIcons.earth_1),
                      ),
                      Text(
                        '인트로',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung60_white),
                      ),
                      Text(
                        '다시 보기',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung60_white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // actions: <Widget>[
      //   GreenButton(
      //     "취소",
      //     onPressed: () => Navigator.of(context).pop(), // 모달 닫기
      //   ),
      //   RedButton(
      //     "종료",
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //       onConfirm();
      //     },
      //   ),
      // ],
    );
    ;
  }
}
