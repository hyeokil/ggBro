import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/history/component/history_date_list.dart';
import 'package:frontend/screens/history/component/history_list.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _RankingState();
}

class _RankingState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final histories = Provider.of<HistoryModel>(context, listen: true).getHistories();
    List<dynamic> dateHistory = [];
    dateHistory.addAll(histories);

    var groupedByDate = groupBy(dateHistory, (dynamic p) {
      return DateTime.parse(p['create_at']).toIso8601String().substring(0, 10); // 날짜만 추출
    });

    List<dynamic> dateFinalHistory = [];
    for (String key in groupedByDate.keys) {
      dateFinalHistory.add({key : groupedByDate['$key']});
    }

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
                    height: MediaQuery.of(context).size.height * 0.82,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: dateFinalHistory.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // margin: EdgeInsets.only(bottom: 5),
                          child: HistoryDateList(
                            dateHistoryList: dateFinalHistory[index],
                          ),
                        );
                      },
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
