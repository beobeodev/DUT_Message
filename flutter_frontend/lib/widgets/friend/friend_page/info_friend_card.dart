import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoFriendCard extends StatelessWidget {
  final String avatar;
  final String name;

  const InfoFriendCard({this.avatar, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.metallicViolet,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              avatar == "" ? "https://www.zimlive.com/dating/wp-content/themes/gwangi/assets/images/avatars/user-avatar.png" : avatar,
            ),
            radius: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: Palette.zodiacBlue,
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtil().setSp(16),
                fontFamily: FontFamily.fontNunito,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}