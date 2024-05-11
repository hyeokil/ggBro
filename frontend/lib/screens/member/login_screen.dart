import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/member/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String? _validatePassword(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$',
      caseSensitive: true,
      multiLine: false,
    );
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (!passwordRegex.hasMatch(value)) {
      return '문자, 숫자, 특수 문자가 포함된 8 ~ 15자를 입력해주세요.';
    }
    return null;
  }

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initConnectivity() async {
  //   late List<ConnectivityResult> result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     // developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   print('여기');
  //   return _updateConnectionStatus(result);
  // }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
    if (!(_connectionStatus.contains(ConnectivityResult.mobile) |
        _connectionStatus.contains(ConnectivityResult.wifi))) {
      _showDialogToTurnOnData();
    }
  }

  void _showDialogToTurnOnData() {
    print('yest');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "데이터 연결 필요",
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung80),
          ),
          content: Text(
            "네트워크 연결상태를 확인해 주세요.",
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.yeonSung60),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () {
                // OpenSettings.openDataRoamingSetting();
                SystemNavigator.pop(); // 대화 상자 닫기
              },
            ),
            // TextButton(
            //   child: Text("설정으로 이동"),
            //   onPressed: () {
            //     OpenSettings.openDataRoamingSetting();
            //     Navigator.of(context).pop(); // 대화 상자 닫기
            //   },
            // ),
            // TextButton(
            //   child: Text("취소"),
            //   onPressed: () {
            //     Navigator.of(context).pop(); // 대화 상자 닫기
            //   },
            // ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                EmailField(controller: _email),
                PasswordField(
                  controller: _password,
                  validator: _validatePassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final auth =
                            Provider.of<AuthModel>(context, listen: false);
                        if (_formKey.currentState!.validate()) {
                          // 유효성 검사를 통과한 경우 로그인 로직을 실행합니다.
                          String email = _email.text;
                          String password = _password.text;
                          // print('이메일 $email 비밀번호 $password');
                          // 여기에 로그인 로직을 구현합니다.
                          AuthStatus loginStatus =
                              await auth.login(email, password);
                          if (loginStatus == AuthStatus.loginSuccess) {
                            var user = Provider.of<UserProvider>(context,
                                listen: false);
                            var tutorial = user.getTutorial();
                            if (tutorial) {
                              context.go('/main');
                            } else {
                              context.go('/intro');
                            }
                          }
                        }
                      },
                      style: const ButtonStyle(),
                      child: const Text("로그인"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _email.text = '';
                          _password.text = '';
                        });
                        context.push('/signUp');
                      },
                      child: const Text("회원가입"),
                    )
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
