import 'dart:convert';
import 'package:flutter_frontend/data/models/custom_error.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static final AuthRepository _singleton = AuthRepository._init();

  AuthRepository._init();

  factory AuthRepository() {
    return _singleton;
  }

  Future<bool> checkUsernameExist(String username) async {
    final Map<String, String> body = {
      "username": username,
    };

    final http.Response response = await AuthProvider.checkUsernameExist(body);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['Exist'];
    } else {
      return false;
    }
  }

  Future<CustomResponse> signUp(Map<String, String> body) async {
    try {
      final http.Response response = await AuthProvider.signUp(body);

      final dynamic signUpResponse = jsonDecode(response.body);

      // print(signUpResponse);

      if (response.statusCode == 400) {
        return CustomResponse(
          statusCode: 400,
          error: true,
          errorMaps: {
            "usernameExist": signUpResponse["validate"]["usernameExist"],
            "phoneExist": signUpResponse["validate"]["phoneExist"],
          },
        );
      } else if (response.statusCode == 201) {
        return CustomResponse(
          statusCode: 201,
        );
      }
    } catch (err) {
      print ("Error in signUp() from AuthRepository: $err");
      return CustomResponse(error: true, errorMaps: {
        "exception": err.message,
      },);
    }
    return CustomResponse(
      statusCode: 500,
    );
  }
}