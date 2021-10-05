import 'package:flutter_frontend/screens/login.dart';
import 'package:flutter_frontend/screens/sign_up.dart';
import 'package:get/get.dart';

class GetRouter {
  static const login ="/login";
  static const signUp ="/signUp";

  static List<GetPage> pages = [
    GetPage<dynamic>(name: login, page: () => LoginScreen()),
    GetPage<dynamic>(name: signUp, page: () => SignUpScreen()),
  ];
}
