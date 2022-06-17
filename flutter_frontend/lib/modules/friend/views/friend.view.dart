import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_frontend/modules/friend/widgets/add_friend/add_friend_page.widget.dart';
import 'package:flutter_frontend/modules/friend/widgets/friend_page/list_friend_page.widget.dart';
import 'package:flutter_frontend/modules/friend/widgets/tab_bar.dart';
import 'package:get/get.dart';

class FriendScreen extends GetView<FriendController> {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: FutureBuilder(
            future: controller.getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Lỗi'),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      onPressed: controller.rootController.openDrawer,
                      icon: const Icon(
                        Icons.menu,
                        color: Palette.red100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TabNavigationBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        children: const [
                          ListFriendPage(),
                          AddFriendPage(),
                        ],
                      ),
                    )
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
        backgroundColor: Palette.gray200,
      ),
    );
  }
}
