import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/widgets/friend_page/friend_card.widget.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListFriendPage extends GetView<FriendController> {
  const ListFriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: controller.friends.isEmpty
          ? Center(
              child: Text(
                'Không có bạn bè nào!',
                style: TextStyle(
                  color: Palette.zodiacBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  fontFamily: FontFamily.fontNunito,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedTextFormField(
                  onChanged: controller.onChangeTextFieldFindFriend,
                  hintText: 'Nhập tên cần tìm',
                  borderRadius: 50,
                  borderColor: Colors.white,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Palette.red100,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Danh sách bạn bè:',
                  style: TextStyle(
                    color: Palette.zodiacBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    fontFamily: FontFamily.fontNunito,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.filteredFriends.length,
                      itemBuilder: (context, index) {
                        return FriendCard(
                          name: controller.filteredFriends[index].name,
                          avatar: controller.filteredFriends[index].avatar,
                          onTapCard: () {
                            controller.onTapFriendCard(index);
                          },
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
