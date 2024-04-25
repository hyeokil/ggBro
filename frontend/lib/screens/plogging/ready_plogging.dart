import 'package:flutter/material.dart';

class ReadyPlogging extends StatefulWidget {
  const ReadyPlogging({super.key});

  @override
  State<ReadyPlogging> createState() => _ReadyPloggingState();
}

class _ReadyPloggingState extends State<ReadyPlogging> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text('플로깅 준비 페이지요'),
          )),
    );
  }
}
