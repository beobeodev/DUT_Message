import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
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

  List<FriendRequest> listAddFriendRequest = [];
  List<User> listFriend = [];

  UserRepository._init();

  Future<void> initData() async {
    await getListFriend();
    await getListAddFriendRequest();
  }

  // this function to get info of user by phone number
  Future<CustomResponse> getUserByPhoneNumber(String phoneNumber) async {
    try {
      final Map<String, String> body = {
        "phone": phoneNumber
      };

      final Map<String, String> header = {
        "accessToken": localRepository.accessToken,
        "refreshToken": localRepository.refreshToken,
        "id": localRepository.infoCurrentUser.id,
      };

      final http.Response responseGetUser = await HttpProvider.postRequest("${dotenv.env['API_URL']}/user/find-by-phone", body: body, header: header);

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
      print("Error in getUserByPhoneNumber() from UserRepository: $err");
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

      final http.Response responseGetUser = await HttpProvider.postRequest("${dotenv.env['API_URL']}/user/checkFriendRequest", body: body, header: header);

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
      print("Error in checkAddFriendRequest() from UserRepository: $err");
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
    try {
      final Map<String, String> header = {
        "accessToken": localRepository.accessToken,
        "refreshToken": localRepository.refreshToken,
        "id": localRepository.infoCurrentUser.id,
      };

      final http.Response response = await HttpProvider.getRequest("${dotenv.env['API_URL']}/user/friend-request", header: header);

      if (response.statusCode == 200) {
        final List<dynamic> listRequest = jsonDecode(response.body);
        final List<FriendRequest> listAddFriendRequestTemp = <FriendRequest>[];
        for (final element in listRequest) {
          listAddFriendRequestTemp.add(
            FriendRequest(
              friendRequestId: element["_id"],
              fromId: element["from"]["_id"],
              toId: element["to"]["_id"],
              name: element["from"]["name"],
              avatar: element["from"]["avatar"],
            ),
          );
        }

        listAddFriendRequest = listAddFriendRequestTemp;

        return CustomResponse(
          responseBody: {
            "result": listAddFriendRequestTemp,
          },
        );
      } else if (response.statusCode == 500) {
        listAddFriendRequest = <FriendRequest>[];

        return CustomResponse(
          statusCode: 404,
          error: true,
          errorMaps: {
            "message": "internal server error",
          },
        );
      }
    } catch (err) {
      print("Error in getListAddFriendRequest() from UserRepository: $err");
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

  // this function to get list friend r
  Future<CustomResponse> getListFriend() async {
    try {
      final Map<String, String> header = {
        "accessToken": localRepository.accessToken,
        "refreshToken": localRepository.refreshToken,
        "id": localRepository.infoCurrentUser.id,
      };

      final http.Response response = await HttpProvider.getRequest("${dotenv.env['API_URL']}/user/friends", header: header);

      if (response.statusCode == 200) {
        final List<dynamic> listRequest = jsonDecode(response.body);
        final List<User> listFriendTemp = <User>[];

        for (final element in listRequest) {
          // print(element);
          listFriendTemp.add(User.fromMap(element),);
        }

        listFriend = listFriendTemp;

        return CustomResponse(
          responseBody: {
            "result": listFriendTemp,
          },
        );
      } else if (response.statusCode == 500) {
        listFriend = <User>[];

        return CustomResponse(
          statusCode: 404,
          error: true,
          errorMaps: {
            "message": "internal server error",
          },
        );
      }
    } catch (err) {
      print("Error in getListFriend() from UserRepository: $err");
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

  void addFriendToList(User friend) {
    listFriend.add(friend);
  }
}