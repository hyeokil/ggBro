import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/history/component/history_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _RankingState();
}

class _RankingState extends State<HistoryScreen> {
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
          child: Column(
            children: [
              TopBar(),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HistoryList(),
                      HistoryList(),
                      HistoryList(),
                      HistoryList(),
                      HistoryList(),
                      HistoryList(),
                      HistoryList(),
                      HistoryList(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
