import 'package:flutter/material.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _RankingState();
}

class _RankingState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            TopBar(),
            Center(
              child: Text('캠페인페이지요'),
            ),
          ],
        ),
      ),
    );
  }
}
