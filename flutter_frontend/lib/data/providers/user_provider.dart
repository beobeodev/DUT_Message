import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static Future<http.Response> getUserByPhoneNumber(Map<String, String> body, Map<String, String> header) async {
    final http.Response response = await http.post(
      Uri.parse("${ApiPath.userServerUrl}/find-by-phone"),
      body: body,
      headers: header,
    );
    return response;
  }
}