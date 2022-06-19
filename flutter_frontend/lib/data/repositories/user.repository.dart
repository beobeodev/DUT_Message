import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';
import 'package:flutter_frontend/data/models/friend_request.model.dart';
import 'package:flutter_frontend/data/models/user.model.dart';

class UserRepository {
  UserRepository();

  Future<UserModel> getUserByPhoneNumber(String phoneNumber) async {
    final Map<String, String> body = {'phone': phoneNumber};

    final Map<String, dynamic> rawData = await DioProvider.post(
      url: '/user/find-by-phone',
      formBody: body,
      // headers: AuthorizationUtil.header,
    );

    return UserModel.fromJson(rawData);
  }

  Future<Map<String, dynamic>> checkAddFriendRequest(String toId) async {
    final Map<String, String> body = {'toId': toId};

    final Map<String, dynamic> responseGetUser = await DioProvider.post(
      url: '/user/checkFriendRequest',
      formBody: body,
      // headers: AuthorizationUtil.header,
    );

    return responseGetUser;
  }

  Future<List<FriendRequestModel>> getAddFriendRequests() async {
    final List<dynamic> rawData = await DioProvider.get(
      url: '/user/friend-request',
      // headers: AuthorizationUtil.header,
    );

    final List<FriendRequestModel> result =
        rawData.map((e) => FriendRequestModel.fromMap(e)).toList();
    return result;
  }

  Future<List<UserModel>> getFriends() async {
    final List<dynamic> rawData = await DioProvider.get(
      url: '/user/friends',
      // headers: AuthorizationUtil.header,
    );

    final List<UserModel> userFriends =
        rawData.map((e) => UserModel.fromJson(e)).toList();

    return userFriends;
  }

  Future<Map<String, dynamic>> updateProfile(UserModel newUser) async {
    final Map<String, String> body = {
      'name': newUser.name,
      'avatar': newUser.avatar,
      'email': newUser.email ?? '',
    };

    final Map<String, dynamic> rawData = await DioProvider.post(
      url: '/user/update-info',
      formBody: body,
      // headers: AuthorizationUtil.header,
    );

    return rawData;
  }
}
