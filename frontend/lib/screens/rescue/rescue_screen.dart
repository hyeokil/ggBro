import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';

class RescueScreen extends StatefulWidget {
  const RescueScreen({super.key});

  @override
  State<RescueScreen> createState() => _RescueScreenState();
}

class _RescueScreenState extends State<RescueScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            TopBar(),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 3, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.basicShadowGray.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '구  조',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung90),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '쓰레기 더미 속',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung100),
                  ),
                  Text(
                    '동물들을 구해 주세요!',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung100),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(AppIcons.trashs),
            ),
            Container(
              width: MediaQuery.of(context).size.height * 0.15,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: AppColors.rescueButton,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 3, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.basicgray.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  '구조하기',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung90_white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Image.asset(AppIcons.gging),
                  ),
                  Text(
                    ' X 1000 낑',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung90),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
