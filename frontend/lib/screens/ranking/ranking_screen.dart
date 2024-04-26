import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        body: Column(
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
      ),
    );
  }
}
