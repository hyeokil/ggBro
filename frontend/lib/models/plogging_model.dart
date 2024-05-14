import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class PloggingModel with ChangeNotifier {
  final UserProvider userProvider;

  PloggingModel(this.userProvider);

  String address = dotenv.get('ADDRESS');

  late int ploggingId;

  Future<String> ploggingStart(String accessToken, int memberPetId) async {
    var url = Uri.https(address, "/api/v1/plogging/start/$memberPetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    print('ploggingStart request : $url, headers : $headers');
    final response = await http.post(url, headers: headers);
    print(
        'ploggingStart response : ${json.decode(utf8.decode(response.bodyBytes))["dataBody"]}');

    if (response.statusCode == 200) {
      ploggingId = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      return "Success";
    } else {
      return "fail";
    }
  }

  int getPloggingId() {
    return ploggingId;
  }

  late Map<String, dynamic> classificationData;

  Future<String> classificationTrash(String accessToken, double latitude,
      double longitude, List<int> image) async {
    var url = Uri.https(address, "/api/v1/plogging/trash/$ploggingId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode(
        {'latitude': latitude, 'longitude': longitude, 'image': image});
    print(
        'classificationTrash request : $url, headers : $headers body : $body');
    final response = await http.post(url, headers: headers, body: body);

    print(
        'classificationTrash response : ${json.decode(utf8.decode(response.bodyBytes))["dataBody"]}');

    if (response.statusCode == 200) {
      classificationData =
          json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      return 'Success';
    } else {
      return 'fail';
    }
  }

  getClassificationData() {
    return classificationData;
  }

  late Map<String, dynamic> trashLists;

  Future<String> trashList(
      String accessToken, double latitude, double longitude, int radius) async {
    var url = Uri.https(address, "/api/v1/plogging/trash/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode(
        {'latitude': latitude, 'longitude': longitude, 'radius': radius});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      trashLists = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('쓰레기 $trashLists');
      return "Success";
    } else {
      print('안됨');
      return "fail";
    }
  }

  Map<String, dynamic> getTrashLists() {
    return trashLists;
  }
}
