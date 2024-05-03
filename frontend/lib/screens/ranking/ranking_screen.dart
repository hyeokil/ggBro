import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/ranking/component/ranking_bar.dart';
import 'package:frontend/screens/ranking/component/ranking_lists.dart';
import 'package:frontend/screens/ranking/component/ranking_name_bar.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingState();
}

class _RankingState extends State<RankingScreen> {
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
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  TopBar(),
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.75,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Column(
                            children: [
                              RankingNameBar(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              RankingBar(
                                heightSize: 0.2,
                                exp: 700,
                              ),
                            ],
                          ),
                          left: MediaQuery.of(context).size.width * 0.295,
                        ),
                        Positioned(
                          child: Column(
                            children: [
                              RankingNameBar(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              RankingBar(
                                heightSize: 0.12,
                                exp: 600,
                              ),
                            ],
                          ),
                          top: MediaQuery.of(context).size.height * 0.08,
                          left: MediaQuery.of(context).size.width * 0.005,
                        ),
                        Positioned(
                          child: Column(
                            children: [
                              RankingNameBar(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              RankingBar(
                                heightSize: 0.08,
                                exp: 500,
                              ),
                            ],
                          ),
                          right: MediaQuery.of(context).size.width * 0.005,
                          top: MediaQuery.of(context).size.height * 0.12,
                        ),
                      ],
                    ),
                  ),
                  RankingLists(),
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
