import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';

class AuthRepository {
  // Future<CustomResponse> signUp(Map<String, String> body) async {
  //   try {
  //     final http.Response response = await HttpProvider.postRequest(
  //       "${dotenv.env['API_URL']}/auth/signup",
  //       body: body,
  //     );

  //     final dynamic signUpResponse = jsonDecode(response.body);

  //     if (response.statusCode == 400) {
  //       return CustomResponse(
  //         statusCode: 400,
  //         error: true,
  //         errorMaps: {
  //           'usernameExist': signUpResponse['validate']['usernameExist'],
  //           'phoneExist': signUpResponse['validate']['phoneExist'],
  //         },
  //       );
  //     } else if (response.statusCode == 201) {
  //       return CustomResponse(
  //         statusCode: 201,
  //       );
  //     }
  //   } catch (err) {
  //     print('Error in signUp() from AuthRepository: $err');
  //     return CustomResponse(
  //       statusCode: 500,
  //       error: true,
  //       errorMaps: {
  //         'exception': err.toString(),
  //       },
  //     );
  //   }
  //   return CustomResponse(
  //     statusCode: 500,
  //   );
  // }

  Future<void> signUp(Map<String, dynamic> formBody) async {
    return await DioProvider.post(url: '/auth/signup', formBody: formBody);
  }

  Future<void> forgotPassword(Map<String, dynamic> formBody) async {
    return await DioProvider.post(
      url: '/user/forgot-password',
      formBody: formBody,
    );
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> formBody) async {
    final Map<String, dynamic> rawData = await DioProvider.post(
      url: '/auth/login',
      formBody: formBody,
    );
    return rawData;
  }
}
