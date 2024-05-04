import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class AchievementModel with ChangeNotifier {

  final UserProvider userProvider;
  AchievementModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List<dynamic> achievements = [];

  Future<String> getAchievements(String accessToken) async {
    var url = Uri.https(address, "/api/v1/achievement/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      achievements = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print(achievements);
      return "Success";
    } else {
      return "fail";
    }
  }
}