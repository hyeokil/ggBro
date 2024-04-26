import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';
import 'package:frontend/screens/history/dialog/history_detail_dialog.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerLeft,
            child: Text(
              '4월 26일',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung60),
            ),
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                    color: AppColors.basicShadowGreen,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.basicgray.withOpacity(0.5),
                        offset: Offset(0, 4),
                        blurRadius: 1,
                        spreadRadius: 1,
                      )
                    ]),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.004,
                left: MediaQuery.of(context).size.height * 0.004,
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.884,
                  height: MediaQuery.of(context).size.height * 0.075,
                  decoration: BoxDecoration(
                    color: AppColors.basicgreen,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        child: ProfileImage(), // 같이 간 펫
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.19,
                        child: Column(
                          children: [
                            Text(
                              '총 거리',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung60_white,
                              ),
                            ),
                            Text(
                              '2.1 Km',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung80_white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: [
                            Text(
                              '처치한 몬스터 수',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung60_white,
                              ),
                            ),
                            Text(
                              '37 마리',
                              style: CustomFontStyle.getTextStyle(
                                context,
                                CustomFontStyle.yeonSung80_white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return HistoryDetailDialog(
                                  date: '4월 23일',
                                  time: '오전 11:00 ~ 오후 12:00',
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
