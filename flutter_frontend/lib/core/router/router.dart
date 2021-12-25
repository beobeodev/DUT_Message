import 'package:flutter_frontend/modules/drawer/bindings/drawer_binding.dart';
import 'package:flutter_frontend/modules/chat/views/chat.dart';
import 'package:flutter_frontend/modules/drawer/views/drawer.dart';
import 'package:flutter_frontend/modules/forgot_password/views/forgot_password.dart';
import 'package:flutter_frontend/modules/home/views/home.dart';
import 'package:flutter_frontend/modules/login/views/login.dart';
import 'package:flutter_frontend/modules/chat/views/menu_chat.dart';
import 'package:flutter_frontend/modules/onboard/views/onboard.dart';
import 'package:flutter_frontend/modules/sign_up/views/sign_up.dart';
import 'package:flutter_frontend/modules/splash/views/splash.dart';
import 'package:get/get.dart';

class GetRouter {
  static const splash = "/splash";
  static const login = "/login";
  static const forgotPassword = "/forgotPassword";
  static const signUp = "/signUp";
  static const onboard = "/onboard";
  static const home = "/home";
  static const chat = "/chat";
  static const menuChat = "/menuChat";
  static const drawer = "/drawer";

  static List<GetPage> pages = [
    GetPage(name: login, page: () =>  LoginScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: signUp, page: () =>  SignUpScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: onboard, page: () => OnboardScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: chat, page: () => ChatScreen()),
    GetPage(name: menuChat, page: () => MenuChatScreen()),
    GetPage(name: drawer, page: () => DrawerScreen(), binding: DrawerBinding()),
  ];
}
