import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabNavigationBar extends StatelessWidget {
  const TabNavigationBar({this.isOpenListTab, this.onTapListTab, this.onTapAddTab});

  final bool isOpenListTab;
  final void Function() onTapListTab;
  final void Function() onTapAddTab;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return  Container(
      margin: EdgeInsets.only(top: 15, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 8,
            offset: Offset(2, 1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      width: double.infinity,
      height: ScreenUtil().setHeight(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapListTab,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: isOpenListTab
                    ? Palette.crayolaBlue
                    : Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 400),
              width: size.width / 2 - 40,
              height: double.infinity,
              child: Center(
                child: Text(
                  "Danh sách",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(17),
                    fontFamily: FontFamily.fontNunito,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapAddTab,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: !isOpenListTab
                    ? Palette.crayolaBlue
                    : Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              width: size.width / 2 - 40,
              height: double.infinity,
              duration: Duration(milliseconds: 400),
              child: Center(
                child: Text(
                  "Kết bạn",
                  style: TextStyle(
                    color: isOpenListTab
                        ? Palette.crayolaBlue
                        : Colors.white,
                    fontSize: ScreenUtil().setSp(17),
                    fontFamily: FontFamily.fontNunito,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
