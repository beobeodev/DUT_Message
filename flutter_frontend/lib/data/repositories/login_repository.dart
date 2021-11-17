import 'package:http/http.dart' as http;

class LoginRepository {

  factory LoginRepository() {
    return _singleton;
  }

  LoginRepository._init();

  static final LoginRepository _singleton = LoginRepository._init();

  Future<http.Response> login(String username, String password) async {
    try {
      final Map<String, String> body = {
        "username": username,
        "password": password
      };

      final http.Response response = await http.post(
        Uri.parse("http://localhost:3000/api/auth/login"),
        body: body,
      );

      // print(jsonDecode(response.body));

      // if (response.statusCode == 200 ) {
      //   final dynamic loginResponse = jsonDecode(response.body);
      // }
      return response;
    } catch (err) {
      print(err);
    }
  }
}
