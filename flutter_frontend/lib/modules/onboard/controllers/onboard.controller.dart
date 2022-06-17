import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  final HiveLocalRepository localRepository;

  OnboardController({required this.localRepository});

  //This is list data include of imagepath, title, content in onboard screen
  final List<Map<String, String>> pageData = [
    {
      'imagePath': ImagePath.chatLottie,
      'title': 'Trò chuyện',
      'content':
          'Với DUT Message, bạn có thể thỏa thích trò chuyện cùng bạn bè',
    },
    {
      'imagePath': ImagePath.chatLottie,
      'title': 'Trò chuyện',
      'content':
          'Với DUT Message, bạn có thể thỏa thích trò chuyện cùng bạn bè',
    },
    {
      'imagePath': ImagePath.transitionLottie,
      'title': 'Trao đổi dữ liệu',
      'content':
          'Bên cạnh việc nhắn tin, trò chuyện cùng nhau, DUT Message còn cung cấp tính năng gửi dữ liệu như file, ảnh,...',
    }
  ];

  final PageController pageController = PageController();

  //This variable to store current index of PageView
  late RxInt currentIndex;

  //Init data
  @override
  void onInit() {
    super.onInit();
    currentIndex = 0.obs;
  }

  //This function to listen onchange pageview and to change index of page
  void onPageChange(int index) {
    currentIndex.value = index;
  }

  //Thìs function to back previous page
  void onBackPage() {
    pageController.jumpToPage(currentIndex.value - 1);
  }

  //This function to jump to next page
  void onNextPage() {
    pageController.jumpToPage(currentIndex.value + 1);
  }

  //This function to skip intro
  Future<void> onSkip() async {
    localRepository.setNewUser();
    Get.offAllNamed(RouteManager.login);
  }
}
