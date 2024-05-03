import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _email = '';
  String _accessToken = '';
  String _refreshToken = '';
  String _nickName = '';
  late int _profileImage;
  late int _level;
  late int _currency;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    notifyListeners();
  }

  void setNickName(String nickName) {
    _nickName = nickName;
    notifyListeners();
  }

  void setProfileImage(int profileImage) {
    _profileImage = profileImage;
    notifyListeners();
  }

  void setLevel(int level) {
    _level = level;
    notifyListeners();
  }

  void setCurrency(int currency) {
    _currency = currency;
    notifyListeners();
  }

  String getEmail() {
    return _email;
  }

  String getAccessToken() {
    return _accessToken;
  }

  String getRefreshToken() {
    return _refreshToken;
  }

  String getNickName() {
    return _nickName;
  }

  int getProfileImage() {
    return _profileImage;
  }

  int getLevel() {
    return _level;
  }

  int getCurrency() {
    return _currency;
  }
}