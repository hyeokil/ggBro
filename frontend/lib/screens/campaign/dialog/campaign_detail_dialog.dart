import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class CampaignDetailDialog extends StatefulWidget {
  const CampaignDetailDialog({super.key});

  @override
  State<CampaignDetailDialog> createState() => _CampaignDetailDialogState();
}

class _CampaignDetailDialogState extends State<CampaignDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            color: Colors.black,
            child: Center(
              child: Text(
                '대충 뭐 캠페인 포스터',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung60_white),
              ),
            ),
          )),
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
  }
}
