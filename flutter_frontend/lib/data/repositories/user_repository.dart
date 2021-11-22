import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/providers/user_provider.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  final LocalRepository localRepository = LocalRepository();

  static final UserRepository _singleton = UserRepository._init();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._init();

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

      final http.Response response = await UserProvider.getUserByPhoneNumber(body, header);

      print(response.body);
    } catch (err) {
      print(err);
    }
  }
}