import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRepository {

  factory LoginRepository() {
    return _singleton;
  }

  LoginRepository._init();

  static final LoginRepository _singleton = LoginRepository._init();

  Future<dynamic> login(String username, String password) async {
    try {
      final Map<String, String> body = <String, String>{
        "username": username,
        "password": password
      };

      final http.Response response = await http.post(
        Uri.parse("http://192.168.1.8:3000/api/auth/login"),
        body: body,
      );

      if (response.statusCode == 200 ) {
        final dynamic loginResponse = jsonDecode(response.body);
      }
    } catch (err) {
      print(err);
    }
  }
}
