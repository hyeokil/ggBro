import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;
//
// enum AuthStatus {
//   registerSuccess,
//   registerFail,
//   loginSuccess,
//   loginFail,
//   logoutSuccess,
//   logoutFail,
//   signOutSuccess,
//   signOutFail,
//   inputError,
// }

class AuthModel with ChangeNotifier {

  Future<void> signUp(String email, String password, String nickName) async {
    // var url = Uri.https("j10c101.p.ssafy.io", "api/auth/signup");
    var url = Uri.parse("http://k10c206.p.ssafy.io:9003/api/v1/member/signup");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password, "nickname": nickName});

    final response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '회원가입 성공');
      return;
    } else {
      Fluttertoast.showToast(msg: '회원가입 실패');
      return;
    }
  }



}