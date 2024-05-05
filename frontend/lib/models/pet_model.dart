import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class PetModel with ChangeNotifier {

  final UserProvider userProvider;
  PetModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List<dynamic> pets = [];

  Future<String> getPets(String accessToken) async {
    var url = Uri.https(address, "/api/v1/pet/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      pets = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      // print(pets);
      return "Success";
    } else {
      return "fail";
    }
  }

  Map<String, dynamic> pet = {};

  Future<String> getPetDetail(String accessToken, int memberPetId) async {
    var url = Uri.https(address, "/api/v1/pet/$memberPetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      pet = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print(pet);
      notifyListeners();
      return "Success";
    } else {
      return "fail";
    }
  }

  Map<String, dynamic> getPet () {
    return pet;
  }
}
