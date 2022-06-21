import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';
import 'package:flutter_frontend/data/datasources/remote/user.datasource.dart';
import 'package:flutter_frontend/data/models/friend_request.model.dart';
import 'package:flutter_frontend/data/models/user.model.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepository({required this.remoteDataSource});

  Future<UserModel> getUserByPhoneNumber(String phoneNumber) async {
    final Map<String, String> body = {'phone': phoneNumber};

    final HttpRequestResponse requestResponse =
        await remoteDataSource.getUserByPhoneNumber(body);

    return UserModel.fromJson(requestResponse.data);
  }

  Future<Map<String, dynamic>> checkAddFriendRequest(String toId) async {
    final Map<String, String> body = {'toId': toId};

    final HttpRequestResponse requestResponse =
        await remoteDataSource.checkAddFriendRequest(body);

    return requestResponse.data;
  }

  Future<List<FriendRequestModel>> getAddFriendRequests() async {
    final List<dynamic> addFriendRequests =
        (await remoteDataSource.getAddFriendRequests()).data;

    final List<FriendRequestModel> result =
        addFriendRequests.map((e) => FriendRequestModel.fromMap(e)).toList();
    return result;
  }

  Future<List<UserModel>> getFriends() async {
    final List<dynamic> getFriendsReponse =
        (await remoteDataSource.getFriends()).data;

    final List<UserModel> userFriends =
        getFriendsReponse.map((e) => UserModel.fromJson(e)).toList();

    return userFriends;
  }

  Future<Map<String, dynamic>> updateProfile(UserModel newUser) async {
    final Map<String, String> body = {
      'name': newUser.name,
      'avatar': newUser.avatar,
      'email': newUser.email ?? '',
    };

    final HttpRequestResponse updateProfileResponse =
        await remoteDataSource.updateProfile(body);

    return updateProfileResponse.data;
  }
}
