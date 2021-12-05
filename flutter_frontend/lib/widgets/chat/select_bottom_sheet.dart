import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SelectBottomSheet extends StatelessWidget {
  final void Function(FileType fileType) onPressItem;

  const SelectBottomSheet({Key key,@required this.onPressItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      snappingPositions: const [
        //Set height of BottomSheet is 0.3 height of screen
        SnappingPosition.factor(
          positionFactor: 0.3,
          snappingCurve: Curves.easeIn,
          snappingDuration: Duration(milliseconds: 100),
        ),
        //Set height expanded is 0.3 height of screen
        SnappingPosition.factor(
          positionFactor: 0.3,
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
          child: Align(
            child: Container(
              width: 68,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
      grabbingHeight: 35,
      sheetBelow: SnappingSheetContent(
        // draggable: true,
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Text(
                  "Chọn kiểu muốn gửi",
                  style: TextStyle(
                    fontFamily: FontFamily.fontNunito,
                    fontWeight: FontWeight.bold,
                    color: Palette.metallicViolet,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: Colors.green,
                    size: 30,
                  ),
                  title: Text(
                    'Ảnh',
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      fontWeight: FontWeight.bold,
                      color: Palette.zodiacBlue,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onPressItem(FileType.image);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.videocam,
                    color: Colors.green,
                    size: 30,
                  ),
                  title: Text(
                    'Video',
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      fontWeight: FontWeight.bold,
                      color: Palette.zodiacBlue,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onPressItem(FileType.video);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.insert_drive_file,
                    color: Colors.green,
                    size: 30,
                  ),
                  title: Text(
                    'File',
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      fontWeight: FontWeight.bold,
                      color: Palette.zodiacBlue,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onPressItem(FileType.any);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
