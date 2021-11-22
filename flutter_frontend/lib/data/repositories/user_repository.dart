import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class UserRepository{
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

      final http.Response response = await UserProvider.getUserByPhoneNumber(body);


    } catch (err) {
      print(err);
    }
  }
}