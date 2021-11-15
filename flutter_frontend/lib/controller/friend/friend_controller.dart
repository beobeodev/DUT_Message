import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  final PageController pageController = PageController();
  final RxBool isOpenListTab = true.obs;
  final RxInt indexPage = 0.obs;

  void onTapListTab() {
    pageController.jumpToPage(0);
    isOpenListTab.value = true;
  }
  void onTapAddTab() {
    pageController.jumpToPage(1);
    isOpenListTab.value = false;
  }

  void onPageChange(int index) {
    isOpenListTab.value = !isOpenListTab.value;
    indexPage.value = index;
  }
}