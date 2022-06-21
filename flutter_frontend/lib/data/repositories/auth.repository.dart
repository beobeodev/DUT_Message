import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';
import 'package:flutter_frontend/data/datasources/remote/auth.datasource.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

  Future<void> signUp(Map<String, dynamic> formBody) async {
    await remoteDataSource.signUp(formBody);
  }

  Future<void> forgotPassword(Map<String, dynamic> formBody) async {
    await remoteDataSource.forgotPassword(formBody);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> formBody) async {
    final HttpRequestResponse requestResponse = await DioProvider.post(
      url: '/auth/login',
      formBody: formBody,
    );
    return requestResponse.data;
  }
}
