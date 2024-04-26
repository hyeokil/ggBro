import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/component/topbar/profile_image.dart';

class RankingList extends StatefulWidget {
  final int rank;
  final String nickName;
  final int score;

  const RankingList({
    super.key,
    required this.rank,
    required this.nickName,
    required this.score,
  });

  @override
  State<RankingList> createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.125,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(color: Colors.black),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.07,
            // color: Colors.red,
            child: Center(
              child: Text(
                '${widget.rank}',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung80),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.12,
            child: Container(
              height: 45,
              width: 45,
              child: ProfileImage(),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                '${widget.nickName}',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung80),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.005,
            child: Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.17,
              child: Text(
                '${widget.score} exp',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.yeonSung70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
