import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/bottom_sheet_select/select_item.widget.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SelectBottomSheet extends StatelessWidget {
  final void Function(FileType fileType) onPressItem;

  const SelectBottomSheet({Key? key, required this.onPressItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
      snappingPositions: const [
        SnappingPosition.factor(
          positionFactor: 0.4,
          snappingCurve: Curves.easeIn,
          snappingDuration: Duration(milliseconds: 100),
        ),
        SnappingPosition.factor(
          positionFactor: 0.4,
          snappingCurve: Curves.easeIn,
          snappingDuration: Duration(milliseconds: 100),
        ),
      ],
      grabbing: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(
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
                SelectItem(
                  icon: Icons.image,
                  title: 'Ảnh',
                  onTap: () {
                    Get.back();
                    onPressItem(FileType.image);
                  },
                ),
                SelectItem(
                  icon: Icons.videocam,
                  title: 'Video',
                  onTap: () {
                    Get.back();
                    onPressItem(FileType.video);
                  },
                ),
                SelectItem(
                  icon: Icons.insert_drive_file,
                  title: 'File',
                  onTap: () {
                    Get.back();
                    onPressItem(FileType.any);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
