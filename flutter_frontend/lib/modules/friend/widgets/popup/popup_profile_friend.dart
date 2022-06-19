import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_frontend/core/constants/enums/add_friend_status.enum.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/have_receive_content.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/have_send_content.dart';
import 'package:flutter_frontend/modules/friend/widgets/popup/is_friend_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PopUpProfileFriend extends GetView<FriendController> {
  final UserModel infoFriend;
  final AddFriendStatus addFriendStatus;

  const PopUpProfileFriend({
    Key? key,
    required this.infoFriend,
    required this.addFriendStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile',
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: Get.width / 2 + 100,
          height: Get.height / 2.8,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  infoFriend.avatar,
                ),
                radius: 50,
              ),
              Text(
                infoFriend.name,
                style: TextStyle(
                  fontFamily: FontFamily.fontNunito,
                  color: Palette.zodiacBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(22),
                ),
                textAlign: TextAlign.center,
              ),
              _buildFriendContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFriendContent() {
    switch (addFriendStatus) {
      case AddFriendStatus.haveSendAddFriendRequest:
        return const HaveSendContent();
      case AddFriendStatus.haveReceiveAddFriendRequest:
        return HaveReceiveContent(
          onTapAccept: () {
            controller.onTapButtonAcceptAddFriendRequest(infoFriend.id);
            Get.back();
          },
        );
      case AddFriendStatus.isFriend:
        return IsFriendContent(
          onPressButtonChat: () {
            controller.onTapButtonChat(infoFriend.id);
          },
          onTapButtonCancelFriend: () {
            controller.onTapButtonCancelFriend(infoFriend.id);
          },
        );
      default:
        return Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: const Color(0xFF3570EC),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
            ),
            onPressed: () {
              controller.onTapButtonAddFriend(infoFriend.id);
            },
            child: Text(
              'Kết bạn',
              style: TextStyle(
                fontFamily: FontFamily.fontNunito,
                fontSize: ScreenUtil().setSp(16),
              ),
            ),
          ),
        );
    }
  }
}
