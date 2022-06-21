import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/chat/controllers/menu_chat.controller.dart';
import 'package:flutter_frontend/modules/chat/widgets/menu_chat/create_sheet_header.widget.dart';
import 'package:flutter_frontend/widgets/rounded_text_form_field.widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class CreateRoomConversationSheet extends StatefulWidget {
  final List<UserModel> friends;
  final Future<void> Function(List<String>, String) createRoomConversation;

  const CreateRoomConversationSheet({
    Key? key,
    required this.friends,
    required this.createRoomConversation,
  }) : super(key: key);

  @override
  State<CreateRoomConversationSheet> createState() =>
      _CreateRoomConversationSheetState();
}

class _CreateRoomConversationSheetState
    extends State<CreateRoomConversationSheet> {
  final MenuChatController controller = Get.find<MenuChatController>();
  final TextEditingController nameTextController = TextEditingController();

  late List<UserModel> friends;
  late List<UserModel> searchedFriends;
  List<String> selectedFriendIds = [];

  @override
  void initState() {
    super.initState();
    friends = List.from(widget.friends);
    searchedFriends = friends;

    if (!controller.isRoomConversation) {
      selectedFriendIds.add(controller.friendUser.id);
    }
  }

  void onChangedTextFieldFind(String value) {
    setState(() {
      searchedFriends = friends
          .where(
            (element) =>
                element.name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  void selectFriendCard(UserModel selectedFriend) {
    final int searchedFriendIndex = searchedFriends
        .indexWhere((element) => element.id == selectedFriend.id);
    final int friendIndex =
        friends.indexWhere((element) => element.id == selectedFriend.id);

    selectedFriend.isSelected = !selectedFriend.isSelected;

    setState(() {
      friends[friendIndex] = selectedFriend;
      searchedFriends[searchedFriendIndex] = selectedFriend;
    });

    if (selectedFriend.isSelected) {
      selectedFriendIds.add(selectedFriend.id);
    } else {
      selectedFriendIds.remove(selectedFriend.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      snappingPositions: const [
        SnappingPosition.factor(
          positionFactor: 0.92,
          snappingCurve: Curves.easeIn,
          snappingDuration: Duration(milliseconds: 100),
        ),
        //Set height expanded is 0.9 height of screen
        SnappingPosition.factor(
          positionFactor: 0.92,
          snappingCurve: Curves.easeIn,
          snappingDuration: Duration(milliseconds: 100),
        ),
      ],
      grabbing: CreateSheetHeader(
        onTapButtonCreate: () async {
          await widget.createRoomConversation(
            selectedFriendIds,
            nameTextController.text,
          );
        },
      ),
      grabbingHeight: 42,
      sheetBelow: SnappingSheetContent(
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18.0, right: 18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: RoundedTextFormField(
                    textController: nameTextController,
                    hintText: 'Nhập tên nhóm (tuỳ chọn)',
                    borderColor: Colors.transparent,
                    borderRadius: 45,
                    fillColor: Colors.blueGrey[50]!,
                  ),
                ),
                const Divider(
                  thickness: 1.4,
                  color: Palette.zodiacBlue,
                  height: 40,
                ),
                SizedBox(
                  height: 45,
                  child: RoundedTextFormField(
                    onChanged: onChangedTextFieldFind,
                    hintText: 'Tìm bạn thêm vào nhóm',
                    borderColor: Colors.transparent,
                    borderRadius: 45,
                    fillColor: Colors.blueGrey[50]!,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Palette.gray300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedFriends.length,
                    itemBuilder: (context, index) {
                      final UserModel currentFriend = searchedFriends[index];
                      return GestureDetector(
                        onTap: () {
                          selectFriendCard(currentFriend);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: currentFriend.isSelected
                                  ? Palette.blue100
                                  : Palette.gray300,
                              width: 1.3,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  currentFriend.avatar,
                                ),
                                radius: 15,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  currentFriend.name,
                                  style: TextStyle(
                                    color: Palette.zodiacBlue,
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontFamily: FontFamily.fontNunito,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
