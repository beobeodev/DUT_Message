import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static Future<http.Response> getUserByPhoneNumber(Map<String, String> body) async {
    final http.Response response = await http.post(
      Uri.parse("${ApiPath.userServerUrl}/find-by-phone"),
      body: body,
    );
    return response;
  }
}