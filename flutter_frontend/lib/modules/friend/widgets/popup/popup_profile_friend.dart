import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend_controller.dart';
import 'package:flutter_frontend/core/constants/enum.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/have_receive_content.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/have_send_content.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/is_friend_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpProfileFriend extends StatelessWidget {
  final String imageURL;
  final String name;
  final String id;
  final FriendController friendController;
  final AddFriendStatus addFriendStatus;

  const PopUpProfileFriend({this.imageURL, this.name, this.id, this.friendController, this.addFriendStatus});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile",
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: ScreenUtil().screenWidth/2 + 100,
          height: ScreenUtil().screenHeight/2 - 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageURL == "" ? "https://www.zimlive.com/dating/wp-content/themes/gwangi/assets/images/avatars/user-avatar.png" : imageURL,
                ),
                radius: 50,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: FontFamily.fontNunito,
                  color: Palette.zodiacBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(22),
                ),
                textAlign: TextAlign.center,
              ),
              if (addFriendStatus == AddFriendStatus.isFriend) IsFriendContent(
                onPressButtonChat: () {
                  friendController.onPressButtonChat(id);
                },
              )
              else if (addFriendStatus == AddFriendStatus.haveSendAddFriendRequest) HaveSendContent()
              else if (addFriendStatus == AddFriendStatus.haveReceiveAddFriendRequest) HaveReceiveContent()
              else if (addFriendStatus == AddFriendStatus.noAddFriendRequest) Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color(0xFF3570EC),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                  onPressed: () {
                    friendController.onPressAddFriend(id);
                  },
                  child: Text(
                    'Kết bạn',
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
