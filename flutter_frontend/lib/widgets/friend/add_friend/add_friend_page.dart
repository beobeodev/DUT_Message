import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/friend/add_friend/add_friend_request_card.dart';
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
                    errorText: friendController.errorPhoneNumber.value == ""
                        ? null
                        : friendController.errorPhoneNumber.value,
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
        GestureDetector(
          onTap: friendController.testFunc,
          child: Text(
            "Lời mời kết bạn:",
            style: TextStyle(
              color: Palette.zodiacBlue,
              fontWeight: FontWeight.w700,
              fontSize: ScreenUtil().setSp(20),
              fontFamily: FontFamily.fontNunito,
            ),
          ),
        ),
        Obx(() {
          return Expanded(
            child: ListView.builder(
              itemCount: friendController.listAddFriendRequest.length,
              itemBuilder: (context, index) {
                return RequestAddFriendCard(
                  avatar: friendController.listAddFriendRequest[index].avatar,
                  name: friendController.listAddFriendRequest[index].name,
                );
              },
            ),
          );
        })
      ],
    );
  }
}


