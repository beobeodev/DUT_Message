import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      width: size.width,
      height: 0.3 * size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Palette.crayolaBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: MediaQuery.of(context).padding.top + 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DUT Message",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.fontPoppins,
                      fontSize: ScreenUtil().setSp(21),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(50),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              CustomTextFormField(
                width: double.infinity,
                height: ScreenUtil().setHeight(80),
                hintText: "Tìm kiếm người dùng",
                borderColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
