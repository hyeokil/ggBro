import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/theme_data.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/router/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'provider/main_provider.dart';
import 'provider/user_provider.dart';

void main() async {
  // dotenv 설정
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");

  // 지도 초기화
  await _initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                AuthModel(Provider.of<UserProvider>(context, listen: false))),
        // ChangeNotifierProvider(create: (context) => AuthModel()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _initialize() async {
  String naverMapId = dotenv.get('NAVER_MAP_ID');
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: '$naverMapId', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 앱 시작 시 권한 받기
  Future<void> requestPermissions() async {
    await [
      Permission.location,
      Permission.bluetooth,
    ].request();
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      home: const MyHomePage(),
      builder: (context, child) {
        return Container(
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
