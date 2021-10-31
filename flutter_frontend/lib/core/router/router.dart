import 'package:flutter_frontend/screens/login.dart';
import 'package:flutter_frontend/screens/onboard.dart';
import 'package:flutter_frontend/screens/sign_up.dart';
import 'package:flutter_frontend/screens/splash.dart';
import 'package:get/get.dart';

class GetRouter {
  static const splash = "/splash";
  static const login = "/login";
  static const signUp = "/signUp";
  static const onboard = "/onboard";

  static List<GetPage> pages = [
    GetPage<dynamic>(name: login, page: () => LoginScreen()),
    GetPage<dynamic>(name: signUp, page: () => SignUpScreen()),
    GetPage<dynamic>(name: splash, page: () => SplashScreen()),
    GetPage<dynamic>(name: onboard, page: () => OnboardScreen()),
  ];
}
