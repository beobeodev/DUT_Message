import 'package:flutter_frontend/data/models/user.dart';
import 'package:hive/hive.dart';

class LocalRepository {
  static final LocalRepository _singleton = LocalRepository._init();

  String accessToken;
  String refreshToken;
  User infoCurrentUser;

  Box authBox;

  LocalRepository._init() {
    //init hive with jwt box to store token
    initJWTBoxHive();
  }

  factory LocalRepository() {
    return _singleton;
  }

  //This function to init box to store token when login
  Future<void> initJWTBoxHive() async {
    await Hive.openBox('authBox');
    // await Hive.openBox('currentUserBox');
    authBox = Hive.box('authBox');
  }

  // this function to init data get from local
  void initData() {
    accessToken = getAccessToken();
    refreshToken = getRefreshToken();
    infoCurrentUser = User.fromMap(Map<String, dynamic>.from(getCurrentUser()));
  }

  //
  Future<void> setToken(String accessToken, String refreshToken) async {
    await authBox.put('access_token', accessToken);
    await authBox.put('refresh_token', refreshToken);
  }

  Future<void> deleteToken() async {
    await authBox.delete('access_token');
    await authBox.delete('refresh_token');
  }

  String getAccessToken() {
    return authBox.get('access_token');
  }

  String getRefreshToken() {
    return authBox.get('refresh_token');
  }

  Future<void> setNewUser() async {
    await authBox.put('new_user', true);
  }

  bool getNewUser() {
    return authBox.get('new_user');
  }

  Future<void> setCurrentUser(Map<String, dynamic> data) async {
    await authBox.put('current_user', data);
  }

  Map<dynamic, dynamic> getCurrentUser() {
    return authBox.get('current_user');
  }

  Future<void> deleteCurrentUser() async {
    await authBox.delete('current_user');
  }
}