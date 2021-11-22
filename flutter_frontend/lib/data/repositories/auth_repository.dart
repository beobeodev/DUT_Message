import 'dart:convert';
import 'package:flutter_frontend/data/models/custom_error.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/providers/auth_provider.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:flutter_frontend/data/repositories/login_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final LocalRepository localRepository = LocalRepository();

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
      return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
        "exception": err.message,
      },);
    }
    return CustomResponse(
      statusCode: 500,
    );
  }

  Future<CustomResponse> login(String username, String password) async {
    try {
      final Map<String, String> body = {
        "username": username,
        "password": password
      };

      final http.Response response = await AuthProvider.login(body);

      // if login SUCCESS
      if (response.statusCode == 200) {
        // Get response body
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final User currentUser = User.fromMap(responseBody);
        // save data of user and token to local database
        localRepository.setCurrentUser(currentUser.toMap());
        // save access token and refresh token to local database
        localRepository.setToken(responseBody["accessToken"], responseBody["refreshToken"]);
        // print(currentUser.toMap());
        return CustomResponse(
          // default status code is 200
          responseBody: responseBody,
        );
      } else if (response.statusCode == 500) {
        return CustomResponse(
          statusCode: 500,
          error: true,
          errorMaps: {
            "errorPassword": response.body,
          },
        );
      }
    } catch (err) {
      print("Error in login() from AuthRepository: $err");
      return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
          "exception": err,
        },);
    }
    return CustomResponse(
      statusCode: 500,
    );
  }
}