import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/providers/http_provider.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<bool> checkUsernameExist(String username) async {
    final Map<String, String> body = {
      'username': username,
    };

    // final http.Response response = await AuthProvider.checkUsernameExist(body);
    final http.Response response = await HttpProvider.postRequest(
      "${dotenv.env['API_URL']}/auth/checkUsernameExist",
      body: body,
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['Exist'];
    } else {
      return false;
    }
  }

  Future<CustomResponse> signUp(Map<String, String> body) async {
    try {
      final http.Response response = await HttpProvider.postRequest(
        "${dotenv.env['API_URL']}/auth/signup",
        body: body,
      );

      final dynamic signUpResponse = jsonDecode(response.body);

      if (response.statusCode == 400) {
        return CustomResponse(
          statusCode: 400,
          error: true,
          errorMaps: {
            'usernameExist': signUpResponse['validate']['usernameExist'],
            'phoneExist': signUpResponse['validate']['phoneExist'],
          },
        );
      } else if (response.statusCode == 201) {
        return CustomResponse(
          statusCode: 201,
        );
      }
    } catch (err) {
      print('Error in signUp() from AuthRepository: $err');
      return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
          'exception': err.toString(),
        },
      );
    }
    return CustomResponse(
      statusCode: 500,
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
