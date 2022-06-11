import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final HiveLocalRepository localRepository;

  AuthController({required this.localRepository});

  String? accessToken;
  String? refreshToken;
  User? currentUser;
  bool? isNewUser;

  @override
  Future<void> onInit() async {
    await getAllUserData();
    super.onInit();
  }

  Future<void> getAllUserData() async {
    accessToken = await localRepository.getAccessToken();
    refreshToken = await localRepository.getRefreshToken();
    currentUser = await localRepository.getCurrentUser();
    isNewUser = await localRepository.getNewUser();
  }

  Future<void> setCurrentUser(User newUser) async {
    currentUser = newUser;
    await localRepository.setCurrentUser(newUser.toJson());
  }
}
