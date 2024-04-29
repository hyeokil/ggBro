import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/plogging/readyplogging/component/ready_map.dart';

class ReadyPlogging extends StatefulWidget {
  const ReadyPlogging({super.key});

  @override
  State<ReadyPlogging> createState() => _ReadyPloggingState();
}

class _ReadyPloggingState extends State<ReadyPlogging> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // 그라데이션 시작 위치
              end: Alignment.bottomCenter, // 그라데이션 끝 위치
              colors: [
                Color.fromRGBO(203, 242, 245, 1),
                Color.fromRGBO(247, 255, 230, 1),
                Color.fromRGBO(247, 255, 230, 1),
                Color.fromRGBO(247, 255, 230, 1),
                Color.fromRGBO(254, 206, 224, 1),
              ], // 그라데이션 색상 배열
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.03,
                child: CustomBackButton(),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.03,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: AppColors.readyButton,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 3, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.basicgray.withOpacity(0.5),
                        offset: const Offset(0, 4),
                        blurRadius: 1,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.003,
                        left: MediaQuery.of(context).size.width * 0.015,
                        child: Container(
                          child: const Icon(
                            Icons.directions_run_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '   시작하기',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung80_white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.05,
                child: ReadyMap(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
