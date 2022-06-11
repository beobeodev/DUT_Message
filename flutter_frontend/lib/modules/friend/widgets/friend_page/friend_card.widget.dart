import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendCard extends StatelessWidget {
  final String avatar;
  final String name;
  final void Function() onTapCard;

  const FriendCard({
    Key? key,
    required this.avatar,
    required this.name,
    required this.onTapCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.blue200,
            width: 1.2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 55.h,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                avatar,
              ),
              radius: 18,
            ),
            const SizedBox(
              width: 20,
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
      ),
    );
  }
}
