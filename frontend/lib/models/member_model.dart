import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class MemberModel with ChangeNotifier {

  final UserProvider userProvider;
  MemberModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  Map<String, dynamic> member = {};

  Future<String> getMemberInfo(String accessToken) async {
    var url = Uri.https(address, "/api/v1/member/info");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      member = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $member');
      return "Success";
    } else {
      return "fail";
    }
  }

  Map<String, dynamic> getMember() {
    return member;
  }
}
