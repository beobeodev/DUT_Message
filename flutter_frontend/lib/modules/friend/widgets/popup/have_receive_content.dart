import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HaveReceiveContent extends StatelessWidget {
  final void Function() onTapAccept;

  const HaveReceiveContent({Key key, this.onTapAccept}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
      child: Column(
        children: [
          Text(
            "Đã gửi lời mời đến bạn",
            style: TextStyle(
              fontFamily: FontFamily.fontNunito,
              color: Palette.zodiacBlue,
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Palette.sweetRed,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                onPressed: () {
                },
                child: Text(
                  'Từ chối',
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color(0xFF3570EC),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                onPressed: onTapAccept,
                child: Text(
                  'Chấp nhận',
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
