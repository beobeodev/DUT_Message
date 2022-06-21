import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';

class AuthRemoteDataSource {
  Future<HttpRequestResponse> signUp(Map<String, dynamic> formBody) async {
    return await DioProvider.post(url: '/auth/signup', formBody: formBody);
  }

  Future<HttpRequestResponse> forgotPassword(
      Map<String, dynamic> formBody) async {
    return await DioProvider.post(
      url: '/user/forgot-password',
      formBody: formBody,
    );
  }

  Future<HttpRequestResponse> login(Map<String, dynamic> formBody) async {
    return await DioProvider.post(
      url: '/auth/login',
      formBody: formBody,
    );
  }
}
