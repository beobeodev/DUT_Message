import 'package:http/http.dart' as http;

abstract class HttpProvider {
  static Future<http.Response> getRequest(
    String apiLink, {
    Map<String, String> header = const <String, String>{},
  }) async {
    final http.Response response = await http.get(
      Uri.parse(apiLink),
      headers: header,
    );
    return response;
  }

  static Future<http.Response> postRequest(
    String apiLink, {
    required Map<String, String> body,
    Map<String, String> header = const <String, String>{},
  }) async {
    final http.Response response = await http.post(
      Uri.parse(apiLink),
      body: body,
      headers: header,
    );
    return response;
  }
}
