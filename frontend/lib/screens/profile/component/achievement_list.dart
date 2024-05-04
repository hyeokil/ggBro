import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class AchievementList extends StatefulWidget {
  final int goal;
  final int progress;
  final int index;

  const AchievementList({
    super.key,
    required this.goal,
    required this.progress,
    required this.index,
  });

  @override
  State<AchievementList> createState() => _AchievementListState();
}

class _AchievementListState extends State<AchievementList> {
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
                widget.index == 0
                    ? '플로깅 원정 ${widget.goal}회 출정하기'
                    : widget.index == 1
                        ? '원정 거리 ${widget.goal}Km 주파'
                        : widget.index == 2
                            ? '펫 ${widget.goal}종 모집'
                            : widget.index == 3
                                ? '미쪼몬 ${widget.goal}마리 처치 하기'
                                : widget.index == 4
                                    ? '플라몽 ${widget.goal}마리 처치 하기'
                                    : widget.index == 5
                                        ? '포 캔몽 ${widget.goal}마리 처치 하기'
                                        : '율몽 ${widget.goal}마리 처치 하기',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
              Text(
                widget.goal <= widget.progress
                    ? '100'
                    : '${widget.progress}/${widget.goal}',
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
