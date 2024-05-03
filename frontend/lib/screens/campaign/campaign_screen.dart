import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/campaign/component/campaign_list.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _RankingState();
}

class _RankingState extends State<CampaignScreen> {
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
          ), // 전
          child: Stack(
            children: [
              Column(
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
                        '캠페인',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung90),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                          CampaignList(
                            title: '아따 제목이랑께랑 까랑',
                            period: '2024 / 04 / 09 ~ 2024 / 05 / 20',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
