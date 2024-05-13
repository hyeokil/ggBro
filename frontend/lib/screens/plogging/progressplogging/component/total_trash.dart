import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class TotalTrash extends StatefulWidget {
  final int plastic, can, glass, normal;
  const TotalTrash({
    super.key,
    required this.plastic,
    required this.can,
    required this.glass,
    required this.normal,
  });

  @override
  State<TotalTrash> createState() => _TotalTrashState();
}

class _TotalTrashState extends State<TotalTrash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.37,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: AppColors.basicgray.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              '총 처치 현황',
              style: CustomFontStyle.getTextStyle(
                context,
                CustomFontStyle.yeonSung60,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Image.asset(
              AppIcons.plamong,
              width: 30,
              height: 30,
            ),
            Text(
              '플라몽 처치 : ${widget.plastic}',
              style: CustomFontStyle.getTextStyle(
                context,
                CustomFontStyle.yeonSung60,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Image.asset(
              AppIcons.pocanmong,
              width: 30,
              height: 30,
            ),
            Text(
              '포 캔몽 처치 : ${widget.can}',
              style: CustomFontStyle.getTextStyle(
                context,
                CustomFontStyle.yeonSung60,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Image.asset(
              AppIcons.yulmong,
              width: 30,
              height: 30,
            ),
            Text(
              '율몽 처치 : ${widget.glass}',
              style: CustomFontStyle.getTextStyle(
                context,
                CustomFontStyle.yeonSung60,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Image.asset(
              AppIcons.mizzomon,
              width: 30,
              height: 30,
            ),
            Text(
              '미쪼몽 처치 : ${widget.normal}',
              style: CustomFontStyle.getTextStyle(
                context,
                CustomFontStyle.yeonSung60,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
