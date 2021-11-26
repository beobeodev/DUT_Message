import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/friend/friend_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/friend/friend_page/info_friend_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListFriendPage extends StatelessWidget {
  final FriendController friendController;

  const ListFriendPage({this.friendController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // controller: friendController.phoneNumberEditingController,
            // onFieldSubmitted: friendController.onSubmitFindFriend,
            onChanged: friendController.onChangeTextFieldFindFriend,
            decoration: InputDecoration(
              hintText: 'Nhập tên cần tìm',
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
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
              hintStyle: TextStyle(
                fontSize: 15,
                color: Palette.americanSilver,
              ),
              helperText: "",
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
          ),
          Text(
            "Danh sách bạn bè:",
            style: TextStyle(
              color: Palette.zodiacBlue,
              fontWeight: FontWeight.w700,
              fontSize: ScreenUtil().setSp(20),
              fontFamily: FontFamily.fontNunito,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(6),
          ),
          Obx(
              () => Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0.1),
                itemCount: friendController.listFriendFilter.length,
                itemBuilder: (context, index) {
                  return InfoFriendCard(
                    name: friendController.listFriendFilter[index].name,
                    avatar: friendController.listFriendFilter[index].avatar,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
