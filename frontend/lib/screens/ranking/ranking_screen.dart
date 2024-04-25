import 'package:flutter/material.dart';
import 'package:frontend/screens/component/top_bar.dart';

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
              Center(
                child: Text('랭킹페이지요'),
              ),
            ],
          )),
    );
  }
}
