import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/chat/menu_chat_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class AddGroupBottomSheet extends StatelessWidget {
  final MenuChatController menuChatController;

  const AddGroupBottomSheet({Key key, this.menuChatController}) : super(key: key);

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
      grabbing: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Huỷ",
                  style: TextStyle(
                    color: Palette.blue,
                    fontFamily: FontFamily.fontNunito,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                "Nhóm mới",
                style: TextStyle(
                  color: Palette.blue,
                  fontFamily: FontFamily.fontNunito,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: menuChatController.onTapCreateButton,
                child: Text(
                  "Tạo",
                  style: TextStyle(
                    color: Palette.blue,
                    fontFamily: FontFamily.fontNunito,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      grabbingHeight: 42,
      sheetBelow: SnappingSheetContent(
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18.0, right: 18.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập tên nhóm (tuỳ chọn)',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    isDense: true,
                    // errorText:,
                    contentPadding: EdgeInsets.only(
                      left: 16, top: 13, bottom: 12,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    color: Palette.zodiacBlue,
                  ),
                  controller: menuChatController.nameEditingController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: menuChatController.onChangeTextFieldFind,
                  controller: menuChatController.findEditingController,
                  decoration: InputDecoration(
                    hintText: 'Tìm bạn thêm vào nhóm',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey[50]),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    isDense: true,
                    // errorText:,
                    contentPadding: EdgeInsets.only(
                      left: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    color: Palette.zodiacBlue,
                  ),
                  // controller: chatController.inputEditingController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: menuChatController.listSearchFriend.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // print(menuChatController.findEditingController.text);
                            menuChatController.onTapSelectFriend(menuChatController.listSearchFriend[index]["user"]);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: menuChatController.listSearchFriend[index]["beSelected"] ? Colors.blue : Palette.lighterBlack,
                                width: menuChatController.listSearchFriend[index]["beSelected"] ? 2 : 1,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            height: ScreenUtil().setHeight(40),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    menuChatController.listSearchFriend[index]["user"].avatar,
                                  ),
                                  radius: 15,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    menuChatController.listSearchFriend[index]["user"].name,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
