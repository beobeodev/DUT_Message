import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_frontend/core/constants/enum.dart';
import 'package:flutter_frontend/core/router/router.dart';
import 'package:flutter_frontend/core/utils/socket_util.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreenController extends GetxController {
  final LocalRepository localRepository = LocalRepository();
  final SocketController socketController = Get.put(SocketController());

  //Check whether drawer is open or not
  final RxBool isDrawerOpen = false.obs;

  final RxDouble xOffset = 0.0.obs;
  final RxDouble yOffset = 0.0.obs;
  final RxDouble scaleFactor  = 1.0.obs;

  // default screen is home screen
  final Rx<CurrentScreen> currentPage = CurrentScreen.home.obs;

  User currentUser;

  //This list to store title and icon of menu item
  final List<Map<String, dynamic>> listMenuItem = [
    <String, dynamic>{
      "title": "Nhắn tin",
      "icon": FontAwesomeIcons.commentAlt,
    },
    <String, dynamic>{
      "title": "Bạn bè",
      "icon": FontAwesomeIcons.userFriends
    },
    <String, dynamic>{
      "title": "Hồ sơ",
      "icon": FontAwesomeIcons.idBadge,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    currentUser = localRepository.infoCurrentUser;
  }


  final ReceivePort _port = ReceivePort();

  @override
  void onReady() {
      super.onReady();
      bindBackgroundIsolate();
  }

  void bindBackgroundIsolate() {
    final bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      // int progress = data[2];
      print(data);
    });
    print("STATUS REGISTER PORT: $isSuccess");
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
    // print(send);
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
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

  //This function to handle onTap event of menu item
  void onTapMenuItem(IconData icon) {
    if (icon == FontAwesomeIcons.commentAlt) {
      currentPage.value = CurrentScreen.home;
    } else if (icon == FontAwesomeIcons.userFriends) {
      currentPage.value = CurrentScreen.friend;
    } else if (icon == FontAwesomeIcons.idBadge) {
      currentPage.value = CurrentScreen.profile;
    }
    closeDrawer();
  }

  //This function to handle event onTap of logout button
  Future<void> onTapLogoutButton() async {
    await localRepository.removeAllData();
    Get.offAllNamed(GetRouter.login);
  }

  Future<void> onPressFacebookButton() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/145408438926727';
    } else {
      fbProtocolUrl = 'fb://page/145408438926727';
    }

    const String fallbackUrl = 'https://www.facebook.com/bachkhoaDUT';

    try {
      final bool launched = await launch(fbProtocolUrl, forceSafariVC: false, forceWebView: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}