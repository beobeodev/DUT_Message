import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddFriendPage extends StatelessWidget {
  final FriendController friendController;

  const AddFriendPage({this.friendController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                return TextFormField(
                  controller: friendController.phoneNumberEditingController,
                  onTap: friendController.onTapTextField,
                  decoration: InputDecoration(
                    hintText: 'Nhập số điện thoại cần tìm',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.celticBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.celticBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Palette.americanSilver,
                    ),
                    errorText: friendController.errorPhoneNumber.value == "" ? null : friendController.errorPhoneNumber.value,
                    isDense: true,
                    contentPadding: EdgeInsets.only(
                        left: 12, top: 16, bottom: 16,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.zodiacBlue,
                  ),
                );
              }),
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: friendController.onTapFindButton,
              child: Hero(
                tag: "find",
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [
                        Color(0xFFDA5AFA),
                        Color(0xFF3570EC),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 70,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Tìm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.fontNunito,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Lời mời kết bạn:",
          style: TextStyle(
            color: Palette.zodiacBlue,
            fontWeight: FontWeight.w700,
            fontSize: ScreenUtil().setSp(20),
            fontFamily: FontFamily.fontNunito,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Palette.crayolaBlue,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 55,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Nguyễn Đình Quốc Đạt",
                  style: TextStyle(
                    color: Palette.zodiacBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(15),
                    fontFamily: FontFamily.fontNunito,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.red,
                icon: Icon(
                  FontAwesomeIcons.times,
                ),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.green,
                icon: Icon(
                  FontAwesomeIcons.check,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
