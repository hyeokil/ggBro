import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class RescueModel with ChangeNotifier {

  final UserProvider userProvider;
  RescueModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  late bool isBox;

  Future<String> rescuePet(String accessToken, int currency, Function(String) onResult) async {
    var url = Uri.https(address, "/api/v1/pet/resque");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.post(url, headers: headers);
    var check = json.decode(utf8.decode(response.bodyBytes))["dataHeader"];
    print('체크 $check');

    if (response.statusCode == 200) {
      onResult("Success");
      var check = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $check');
      userProvider.setCurrency(currency - 1000);
      return "Success";
    } else {
      print('${response.statusCode}');
      onResult("fail");
      return "fail";
    }
  }
}