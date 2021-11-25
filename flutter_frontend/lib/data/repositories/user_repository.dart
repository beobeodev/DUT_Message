import 'dart:convert';
import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/providers/http_provider.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  final LocalRepository localRepository = LocalRepository();

  static final UserRepository _singleton = UserRepository._init();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._init();

  // this function to get info of user by phone number
  Future<CustomResponse> getUserByPhoneNumber(String phoneNumber) async {
    try {
      final Map<String, String> body = {
        "phone": phoneNumber
      };

      final Map<String, String> header = {
        "accessToken": localRepository.getAccessToken(),
        "refreshToken": localRepository.getRefreshToken(),
        "id": localRepository.getCurrentUser()["_id"],
      };

      final http.Response responseGetUser = await HttpProvider.postRequest("${ApiPath.userServerUrl}/find-by-phone", body: body, header: header);

      if (responseGetUser.statusCode == 200) {
        return CustomResponse(
          responseBody: User.fromMap(jsonDecode(responseGetUser.body)).toMap(),
        );
      } else if (responseGetUser.statusCode == 404) {
        return CustomResponse(
          statusCode: 404,
          error: true,
          errorMaps: {
            "message": "phone number not found",
          },
        );
      }
    } catch (err) {
      print(err);
      return CustomResponse(
          statusCode: 500,
          error: true,
          errorMaps: {
            "message": err,
          },
      );
    }
    return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
          "message": "invalid request",
        },
    );
  }

  // this function to check status of add friend request
  Future<CustomResponse> checkAddFriendRequest(String toId) async {
    try {
      final Map<String, String> body = {
        "toId": toId
      };

      final Map<String, String> header = {
        "id": localRepository.getCurrentUser()["_id"],
      };

      final http.Response responseGetUser = await HttpProvider.postRequest("${ApiPath.userServerUrl}/checkFriendRequest", body: body, header: header);

      if (responseGetUser.statusCode == 200) {
        return CustomResponse(
          responseBody: jsonDecode(responseGetUser.body),
        );
      } else if (responseGetUser.statusCode == 500) {
        return CustomResponse(
          statusCode: 500,
          error: true,
          errorMaps: {
            "message": "internal server error",
          },
        );
      }
    } catch (err) {
      print(err);
      return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
          "message": err,
        },
      );
    }
    return CustomResponse(
      statusCode: 500,
      error: true,
      errorMaps: {
        "message": "invalid request",
      },
    );
  }

  // this function to get list add friend request
  Future<CustomResponse> getListAddFriendRequest() async {

  }
}