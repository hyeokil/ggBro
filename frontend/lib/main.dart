import 'package:flutter/material.dart';
import 'package:frontend/core/theme/theme_data.dart';
import 'package:frontend/router/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // 그라데이션 시작 위치
              end: Alignment.bottomCenter, // 그라데이션 끝 위치
              colors: [
                Color(0xFFEAFFE8), // HEX 색상 코드
                Color(0xFF9CFFB2),
              ], // 그라데이션 색상 배열
            ),
          ), // 전체 배경색으로 파란색 설정
          child: child, // 앱의 나머지 부분
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: globalRouter,
      theme: CustomThemeData.themeData,
    );
  }
}
