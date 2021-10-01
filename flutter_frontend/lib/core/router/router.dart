import 'package:flutter_frontend/screens/login.dart';
import 'package:get/get.dart';

class GetRouter {
  static const login ="/login";

  static List<GetPage> pages = [
    GetPage<dynamic>(name: login, page: () => LoginScreen()),
  ];
}
