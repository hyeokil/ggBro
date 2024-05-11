import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';

class RankingNameBar extends StatefulWidget {
  final String nickName;

  const RankingNameBar({
    super.key,
    required this.nickName,
  });

  @override
  State<RankingNameBar> createState() => _RankingNameBarState();
}

class _RankingNameBarState extends State<RankingNameBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Stack(
        children: [
          Positioned(
            child: ProfileImage(
              image: Image.asset(AppIcons.meka_sudal),
              isPressed: false,
            ),
            left: MediaQuery.of(context).size.width * 0.045,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: AppColors.basicgray,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.basicgray.withOpacity(0.5),
                      offset: Offset(0, 4),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
              ),
              child: Center(
                child: Text(
                  '${widget.nickName}',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung55_white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
