import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';

class UserRepository {
  final HiveLocalRepository localRepository;

  UserRepository({required this.localRepository});

  Future<User> getUserByPhoneNumber(String phoneNumber) async {
    final Map<String, String> body = {'phone': phoneNumber};

    final Map<String, String> header = {
      'accessToken': localRepository.accessToken!,
      'refreshToken': localRepository.refreshToken!,
      'id': localRepository.currentUser!.id,
    };

    final Map<String, dynamic> rawData = await DioProvider.post(
      url: '/user/find-by-phone',
      formBody: body,
      headers: header,
    );

    return User.fromJson(rawData);
  }

  Future<Map<String, dynamic>> checkAddFriendRequest(String toId) async {
    final Map<String, String> body = {'toId': toId};

    final Map<String, String> header = {
      'id': localRepository.currentUser!.id,
    };

    final Map<String, dynamic> responseGetUser = await DioProvider.post(
      url: '/user/checkFriendRequest',
      formBody: body,
      headers: header,
    );

    return responseGetUser;
  }

  Future<List<FriendRequest>> getAddFriendRequests() async {
    final Map<String, String> header = {
      'accessToken': localRepository.accessToken!,
      'refreshToken': localRepository.refreshToken!,
      'id': localRepository.currentUser!.id,
    };

    final List<dynamic> rawData = await DioProvider.get(
      url: '/user/friend-request',
      headers: header,
    );

    final List<FriendRequest> result =
        rawData.map((e) => FriendRequest.fromMap(e)).toList();
    return result;
  }

  Future<List<User>> getFriends() async {
    final Map<String, String> header = {
      'accessToken': localRepository.accessToken!,
      'refreshToken': localRepository.refreshToken!,
      'id': localRepository.currentUser!.id,
    };

    final List<dynamic> rawData = await DioProvider.get(
      url: '/user/friends',
      headers: header,
    );

    final List<User> userFriends =
        rawData.map((e) => User.fromJson(e)).toList();

    return userFriends;
  }

  Future<Map<String, dynamic>> updateProfile(User newUser) async {
    final Map<String, String> body = {
      'name': newUser.name,
      'avatar': newUser.avatar,
      'email': newUser.email,
    };

    final Map<String, String> header = {
      'accessToken': localRepository.accessToken!,
      'refreshToken': localRepository.refreshToken!,
      'id': localRepository.currentUser!.id,
    };

    final Map<String, dynamic> rawData = await DioProvider.post(
      url: '/user/update-info',
      formBody: body,
      headers: header,
    );
    return rawData;
  }
}
