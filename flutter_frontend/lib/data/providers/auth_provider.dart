import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:http/http.dart' as http;

class AuthProvider {

  static Future<http.Response> checkUsernameExist(Map<String, String> body) async {
    final http.Response response = await http.post(
      Uri.parse("${ApiPath.authServerUrl}/checkUsernameExist"),
      body: body,
    );
    return response;
  }

  static Future<http.Response> signUp(Map<String, String> body) async {
    final http.Response response = await http.post(
      Uri.parse("${ApiPath.authServerUrl}/signup"),
      body: body,
    );
    return response;
  }
}