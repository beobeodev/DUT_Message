import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/friend_request.dart';
import 'package:flutter_frontend/modules/friend/controllers/friend.controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/friend/widgets/add_friend/add_friend_request_card.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddFriendPage extends GetView<FriendController> {
  const AddFriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => RoundedTextFormField(
                  textController: controller.phoneTextController,
                  hintText: 'Nhập số điện thoại cần tìm',
                  borderRadius: 50,
                  borderColor: Colors.white,
                  suffixIconWidget: const Icon(
                    Icons.search,
                    color: Palette.red100,
                  ),
                  keyboardType: TextInputType.number,
                  errorText: controller.errorPhoneNumber.value,
                  onTap: controller.onTapPhoneField,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            TextButton(
              onPressed: controller.onTapButtonFind,
              style: TextButton.styleFrom(
                fixedSize: const Size(50, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: Palette.red100,
              ),
              child: const Hero(
                tag: 'find',
                child: Text(
                  'Tìm',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.fontNunito,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Lời mời kết bạn:',
          style: TextStyle(
            color: Palette.zodiacBlue,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            fontFamily: FontFamily.fontNunito,
          ),
        ),
        Obx(() {
          return Expanded(
            child: ListView.builder(
              itemCount: controller.addFriendRequests.length,
              itemBuilder: (context, index) {
                final FriendRequest currentFriendRequest =
                    controller.addFriendRequests[index];
                return AddFriendRequestCard(
                  avatar: currentFriendRequest.avatar,
                  name: currentFriendRequest.name,
                  onTapAccept: () {
                    controller.onTapButtonAcceptAddFriendRequest(
                      currentFriendRequest.fromId,
                    );
                  },
                  onTapRefuse: () {
                    controller.onTapButtonRefuseAddFriendRequest(
                      currentFriendRequest.friendRequestId,
                      currentFriendRequest.fromId,
                    );
                  },
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
