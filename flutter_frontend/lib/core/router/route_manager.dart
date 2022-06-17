import 'package:flutter_frontend/modules/chat/bindings/chat.binding.dart';
import 'package:flutter_frontend/modules/chat/views/chat.view.dart';
import 'package:flutter_frontend/modules/chat/views/menu_chat.view.dart';
import 'package:flutter_frontend/modules/friend/bindings/friend.binding.dart';
import 'package:flutter_frontend/modules/home/bindings/home.binding.dart';
import 'package:flutter_frontend/modules/home/views/home.view.dart';
import 'package:flutter_frontend/modules/login/bindings/forgot_password.binding.dart';
import 'package:flutter_frontend/modules/login/bindings/login.binding.dart';
import 'package:flutter_frontend/modules/login/views/forgot_password.view.dart';
import 'package:flutter_frontend/modules/login/views/login.view.dart';
import 'package:flutter_frontend/modules/onboard/bindings/onboard.binding.dart';
import 'package:flutter_frontend/modules/onboard/views/onboard.view.dart';
import 'package:flutter_frontend/modules/profile/bindings/profile.binding.dart';
import 'package:flutter_frontend/modules/root/bindings/root.binding.dart';
import 'package:flutter_frontend/modules/root/views/root.view.dart';
import 'package:flutter_frontend/modules/sign_up/bindings/sign_up.binding.dart';
import 'package:flutter_frontend/modules/sign_up/views/sign_up.view.dart';
import 'package:flutter_frontend/modules/splash/bindings/splash.binding.dart';
import 'package:flutter_frontend/modules/splash/views/splash.view.dart';
import 'package:get/get.dart';

abstract class RouteManager {
  static const splash = '/splash';
  static const login = '/login';
  static const forgotPassword = '/forgot_password';
  static const signUp = '/signUp';
  static const onboard = '/onboard';
  static const home = '/home';
  static const chat = '/chat';
  static const menuChat = '/menuChat';
  static const drawer = '/drawer';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: onboard,
      page: () => const OnboardScreen(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: drawer,
      page: () => RootScreen(),
      bindings: [
        RootBinding(),
        HomeBinding(),
        FriendBinding(),
        ProfileBinding()
      ],
    ),
    GetPage(name: home, page: () => const HomeScreen(), binding: HomeBinding()),
    GetPage(name: chat, page: () => const ChatScreen(), binding: ChatBinding()),
    GetPage(name: menuChat, page: () => const MenuChatScreen()),
  ];
}
