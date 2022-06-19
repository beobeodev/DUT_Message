import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';

class AuthRepository {
  Future<void> signUp(Map<String, dynamic> formBody) async {
    return await DioProvider.post(url: '/auth/signup', formBody: formBody);
  }

  Future<void> forgotPassword(Map<String, dynamic> formBody) async {
    return await DioProvider.post(
      url: '/user/forgot-password',
      formBody: formBody,
    );
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> formBody) async {
    final Map<String, dynamic> rawData = await DioProvider.post(
      url: '/auth/login',
      formBody: formBody,
    );
    return rawData;
  }
}
