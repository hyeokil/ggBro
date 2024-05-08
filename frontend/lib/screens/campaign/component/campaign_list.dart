import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/campaign/dialog/campaign_detail_dialog.dart';

class CampaignList extends StatefulWidget {
  final String title;
  final String image;

  const CampaignList({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  State<CampaignList> createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CampaignDetailDialog(image: widget.image);
          },
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  color: AppColors.basicShadowNavy,
                  borderRadius: BorderRadius.circular(10),
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
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.004,
                left: MediaQuery.of(context).size.height * 0.004,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.884,
                  height: MediaQuery.of(context).size.height * 0.075,
                  decoration: BoxDecoration(
                    color: AppColors.basicnavy,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.title}',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.yeonSung90_white),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     '${widget.period}',
                      //     style: CustomFontStyle.getTextStyle(
                      //         context, CustomFontStyle.yeonSung55_white),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
