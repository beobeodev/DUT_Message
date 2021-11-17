import 'package:hive/hive.dart';

class LocalRepository {
  static final LocalRepository _singleton = LocalRepository._init();
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
    authBox = Hive.box('authBox');
  }

  //
  Future<void> writeToken(String accessToken, String refreshToken) async {
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

  Future<void> setNewUser() async {
    await authBox.put('new_user', true);
  }

  bool getNewUser() {
    return authBox.get('new_user');
  }

}