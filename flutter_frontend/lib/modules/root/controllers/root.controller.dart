import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class RootController extends GetxController {
  final HiveLocalRepository localRepository = HiveLocalRepository();
  // final SocketController socketController = Get.put(SocketController());

  final AuthController authController;

  RootController({required this.authController});

  final RxBool isDrawerOpen = false.obs;
  final RxDouble xOffset = 0.0.obs;
  final RxDouble yOffset = 0.0.obs;
  final RxDouble scaleFactor = 1.0.obs;

  final RxInt currentIndexPage = 0.obs;

  late UserModel currentUser;

  //This list to store title and icon of menu item
  final List<Map<String, dynamic>> listMenuItem = [
    <String, dynamic>{
      'title': 'Nhắn tin',
      'icon': FontAwesomeIcons.commentAlt,
    },
    <String, dynamic>{'title': 'Bạn bè', 'icon': FontAwesomeIcons.userFriends},
    <String, dynamic>{
      'title': 'Hồ sơ',
      'icon': FontAwesomeIcons.idBadge,
    },
  ];

  late io.Socket socket;

  @override
  void onInit() {
    super.onInit();
    currentUser = authController.currentUser!;
    setUpSocket();
  }

  void setUpSocket() {
    try {
      socket = io.io(
        dotenv.env['SOCKET_URL'],
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            // .enableAutoConnect()
            // .enableReconnection()// enable auto-connection
            .setQuery({'userId': authController.currentUser!.id}).build(),
      );
      if (socket.disconnected) {
        socket.connect();
      }
      socket.onConnect((_) {
        log('HAS CONNECTED to socket');
      });
    } catch (e) {
      log('Error in setUpSocket from RootController: ${e.toString()}');
      rethrow;
    }
  }

  //This function to implement close drawer
  void closeDrawer() {
    xOffset.value = 0.0;
    yOffset.value = 0.0;
    scaleFactor.value = 1;
    isDrawerOpen.value = false;
  }

  //This function to implement open drawer
  void openDrawer() {
    xOffset.value = 250;
    yOffset.value = 150;
    scaleFactor.value = 0.6;
    isDrawerOpen.value = true;
  }

  void onTapMenuItem(int newIndex) {
    currentIndexPage.value = newIndex;
    closeDrawer();
  }

  //This function to handle event onTap of logout button
  Future<void> onTapLogoutButton() async {
    await localRepository.removeAllData();
    Get.offAllNamed(RouteManager.login);
  }

  // Future<void> onPressFacebookButton() async {
  //   String fbProtocolUrl;
  //   if (Platform.isIOS) {
  //     fbProtocolUrl = 'fb://profile/145408438926727';
  //   } else {
  //     fbProtocolUrl = 'fb://page/145408438926727';
  //   }

  //   const String fallbackUrl = 'https://www.facebook.com/bachkhoaDUT';

  //   try {
  //     final bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

  //     if (!launched) {
  //       await launch(fallbackUrl, forceSafariVC: false);
  //     }
  //   } catch (e) {
  //     await launch(fallbackUrl, forceSafariVC: false);
  //   }
  // }
}
