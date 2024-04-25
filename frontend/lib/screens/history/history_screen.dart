import 'package:flutter/material.dart';
import 'package:frontend/screens/component/top_bar.dart';

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
            Center(child: Text('히스토리페이지요')),
          ],
        ),
      ),
    );
  }
}
