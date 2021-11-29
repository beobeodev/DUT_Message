import 'package:flutter_frontend/bindings/drawer_binding.dart';
import 'package:flutter_frontend/screens/chat.dart';
import 'package:flutter_frontend/screens/drawer.dart';
import 'package:flutter_frontend/screens/home.dart';
import 'package:flutter_frontend/screens/login.dart';
import 'package:flutter_frontend/screens/menu_chat.dart';
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
  static const menuChat = "/menuChat";
  static const drawer = "/drawer";

  static List<GetPage> pages = [
    GetPage(name: login, page: () =>  LoginScreen()),
    GetPage(name: signUp, page: () =>  SignUpScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: onboard, page: () => OnboardScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: chat, page: () => ChatScreen()),
    GetPage(name: menuChat, page: () => MenuChatScreen()),
    GetPage(name: drawer, page: () => DrawerScreen(), binding: DrawerBinding()),
  ];
}
