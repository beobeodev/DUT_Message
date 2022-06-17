import 'package:flutter/cupertino.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecoratedHeader extends StatelessWidget {
  const DecoratedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 120.h,
          child: SvgPicture.asset(
            ImagePath.profileSignUp,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tham gia DUT Message',
            style: TextStyle(
              fontFamily: FontFamily.fontPoppins,
              color: Palette.lighterBlack,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tạo tài khoản',
            style: TextStyle(
              fontFamily: FontFamily.fontNunito,
              color: Palette.zodiacBlue,
              fontSize: 34.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
