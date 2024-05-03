import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/plogging/finishplogging/finish_plogging_dialog.dart';
import 'package:frontend/screens/plogging/progressplogging/component/progress_map.dart';
import 'package:go_router/go_router.dart';

class ProgressPlogging extends StatelessWidget {
  const ProgressPlogging({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: background(),
        child: const Stack(
          children: [
            ProgressMap(),
            FinishButton(),
          ],
        ),
      ),
    ));
  }

  BoxDecoration background() {
    return const BoxDecoration(
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
    );
  }
}

class FinishButton extends StatelessWidget {
  const FinishButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MediaQuery.of(context).size.width * 0.03,
      bottom: MediaQuery.of(context).size.height * 0.03,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const FinishPloggingDialog();
            },
          ).then(
            (value) => context.go('/main'),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.red,
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
              Center(
                child: Text(
                  '종료',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung80_white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
