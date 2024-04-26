import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/ranking/component/ranking_list.dart';

class RankingLists extends StatefulWidget {
  const RankingLists({super.key});

  @override
  State<RankingLists> createState() => _RankingListState();
}

class _RankingListState extends State<RankingLists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.07,
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.005,
                  child: Text(
                    '순위',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung60),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: Text('동료',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60)),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.3,
                  child: Text('닉네임',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60)),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.12,
                  child: Text('점수',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60)),
                ),
              ],
            ),
          ),
          RankingList(rank: 4, nickName: '닉네임이요4', score: 400,),
          RankingList(rank: 5, nickName: '닉네임이요5', score: 300,),
          RankingList(rank: 6, nickName: '닉네임이요6', score: 200,),
          RankingList(rank: 7, nickName: '닉네임이요7', score: 100,),
          RankingList(rank: 8, nickName: '닉네임이요8', score: 90,),
          RankingList(rank: 9, nickName: '닉네임이요9', score: 80,),
          RankingList(rank: 10, nickName: '닉네임이요10', score: 70,),
        ],
      ),
    );
  }
}
