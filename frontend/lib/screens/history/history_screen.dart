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
        body: Column(
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
    );
  }
}
