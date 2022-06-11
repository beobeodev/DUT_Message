import 'package:flutter_frontend/core/constants/key_hive.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:hive/hive.dart';

class HiveLocalRepository {
  String? accessToken;
  String? refreshToken;
  User? currentUser;

  Box? _authBox;

  Future<Box> openAuthBox() async {
    return await Hive.openBox(KeyHive.authBox);
  }

  Future<Box> get authBox async {
    if (_authBox != null) {
      return _authBox!;
    }
    _authBox = await openAuthBox();
    return _authBox!;
  }

  Future<void> getAllNewUserData() async {
    accessToken = await getAccessToken();
    refreshToken = await getRefreshToken();
    currentUser = await getCurrentUser();
  }

  Future<void> setAllNewUserData(
    String accessToken,
    String refreshToken,
    Map<String, dynamic> userData,
  ) async {
    final Box atBox = await authBox;
    await atBox.put(KeyHive.accessToken, accessToken);
    await atBox.put(KeyHive.refreshToken, refreshToken);
    await atBox.put(KeyHive.currentUser, userData);

    accessToken = accessToken;
    refreshToken = refreshToken;
    currentUser = User.fromJson(userData);
  }

  //
  Future<void> setAllToken(String accessToken, String refreshToken) async {
    final Box atBox = await authBox;

    await atBox.put(KeyHive.accessToken, accessToken);
    await atBox.put(KeyHive.refreshToken, refreshToken);
    // print(refreshToken);
  }

  Future<void> deleteAllToken() async {
    final Box atBox = await authBox;

    await atBox.delete(KeyHive.accessToken);
    await atBox.delete(KeyHive.refreshToken);
  }

  Future<String?> getAccessToken() async {
    final Box atBox = await authBox;

    return atBox.get(KeyHive.accessToken);
  }

  Future<String?> getRefreshToken() async {
    final Box atBox = await authBox;

    return atBox.get(KeyHive.refreshToken);
  }

  Future<void> setNewUser() async {
    final Box atBox = await authBox;

    await atBox.put('new_user', true);
  }

  Future<bool?> getNewUser() async {
    final Box atBox = await authBox;

    return atBox.get('new_user');
  }

  Future<void> setCurrentUser(Map<String, dynamic> data) async {
    final Box atBox = await authBox;

    await atBox.put(KeyHive.currentUser, data);
  }

  Future<User?> getCurrentUser() async {
    final Box atBox = await authBox;

    if (atBox.get(KeyHive.currentUser) != null) {
      final Map<String, dynamic> userData =
          Map<String, dynamic>.from(atBox.get(KeyHive.currentUser));
      return User.fromJson(userData);
    }
    return null;
  }

  Future<void> deleteCurrentUser() async {
    final Box atBox = await authBox;

    await atBox.delete(KeyHive.currentUser);
  }

  Future<void> removeAllData() async {
    await deleteAllToken();
    await deleteCurrentUser();
    // await authBox.clear();
    // await authBox.deleteFromDisk();
  }
}
