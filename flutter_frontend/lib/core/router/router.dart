import 'package:flutter_frontend/screens/chat.dart';
import 'package:flutter_frontend/screens/drawer.dart';
import 'package:flutter_frontend/screens/home.dart';
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
  static const home = "/home";
  static const chat = "/chat";
  static const drawer = "/drawer";

  static List<GetPage> pages = [
    GetPage<dynamic>(name: login, page: () => LoginScreen()),
    GetPage<dynamic>(name: signUp, page: () => SignUpScreen()),
    GetPage<dynamic>(name: splash, page: () => SplashScreen()),
    GetPage<dynamic>(name: onboard, page: () => OnboardScreen()),
    GetPage<dynamic>(name: home, page: () => HomeScreen()),
    GetPage<dynamic>(name: chat, page: () => ChatScreen()),
    GetPage<dynamic>(name: drawer, page: () => DrawerScreen()),
  ];
}
