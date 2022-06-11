import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddFriendRequestCard extends StatelessWidget {
  final String avatar;
  final String name;
  final void Function() onTapAccept;
  final void Function() onTapRefuse;

  const AddFriendRequestCard({
    Key? key,
    required this.avatar,
    required this.name,
    required this.onTapAccept,
    required this.onTapRefuse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.blue200,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: ScreenUtil().setHeight(55),
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
          IconButton(
            onPressed: onTapRefuse,
            color: Colors.red,
            icon: const Icon(
              FontAwesomeIcons.times,
            ),
          ),
          IconButton(
            onPressed: onTapAccept,
            color: Colors.green,
            icon: const Icon(
              FontAwesomeIcons.check,
            ),
          )
        ],
      ),
    );
  }
}
