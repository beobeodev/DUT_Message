import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';

class UserRemoteDataSource {
  Future<HttpRequestResponse> getUserByPhoneNumber(
    Map<String, dynamic> formBody,
  ) async {
    return await DioProvider.post(
      url: '/user/find-by-phone',
      formBody: formBody,
      // headers: AuthorizationUtil.header,
    );
  }

  Future<HttpRequestResponse> checkAddFriendRequest(
    Map<String, dynamic> formBody,
  ) async {
    return await DioProvider.post(
      url: '/user/checkFriendRequest',
      formBody: formBody,
      // headers: AuthorizationUtil.header,
    );
  }

  Future<HttpRequestResponse> getAddFriendRequests() async {
    return await DioProvider.get(
      url: '/user/friend-request',
    );
  }

  Future<HttpRequestResponse> getFriends() async {
    return await DioProvider.get(
      url: '/user/friends',
    );
  }

  Future<HttpRequestResponse> updateProfile(
    Map<String, dynamic> formBody,
  ) async {
    return await DioProvider.post(
      url: '/user/update-info',
      formBody: formBody,
    );
  }
}
