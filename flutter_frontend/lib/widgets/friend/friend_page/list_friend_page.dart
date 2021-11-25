import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/widgets/friend/friend_page/info_friend_card.dart';

class ListFriendPage extends StatelessWidget {
  final FriendController friendController;

  const ListFriendPage({this.friendController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0.1),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InfoFriendCard(
            name: "Minh Duc",
            avatar: "",
          );
        },
      ),
    );
  }
}
