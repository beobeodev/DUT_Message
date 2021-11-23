import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpProfileFriend extends StatelessWidget {
  final String imageURL;
  final String name;

  const PopUpProfileFriend({this.imageURL, this.name});

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
                height: ScreenUtil().setHeight(35),
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
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color(0xFF3570EC),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                onPressed: () { },
                child: Text(
                  'Kết bạn',
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
