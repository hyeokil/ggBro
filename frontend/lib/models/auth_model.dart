import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail,
  logoutSuccess,
  logoutFail,
  signOutSuccess,
  signOutFail,
  inputError,
}

class AuthModel with ChangeNotifier {
  final UserProvider userProvider;

  AuthModel(this.userProvider);

  String address = dotenv.get('ADDRESS');

  Future<AuthStatus> signUp(String email, String password, String nickName) async {

    var url = Uri.https(address, "/api/v1/member/signup");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password, "nickname": nickName});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '회원가입이 완료되었습니다.');
      login(email, password);
      return AuthStatus.loginSuccess;
    } else {
      Fluttertoast.showToast(msg: '회원가입에 실패하였습니다.');
      return AuthStatus.loginFail;
    }
  }

  Future<AuthStatus> login(String email, String password) async {

    var url = Uri.https(address, "/api/v1/member/signin");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(url, headers: headers, body: body);
    print('응답 ${response.headers}');

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '로그인이 완료되었습니다.');

      userProvider.setEmail(email);


      return AuthStatus.loginSuccess;
    } else {
      Fluttertoast.showToast(msg: '로그인에 실패하였습니다.');
      return AuthStatus.loginFail;
    }
  }

}