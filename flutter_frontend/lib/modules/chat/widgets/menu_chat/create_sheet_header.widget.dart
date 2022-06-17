import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateSheetHeader extends StatelessWidget {
  final Future<void> Function() onTapButtonCreate;

  const CreateSheetHeader({Key? key, required this.onTapButtonCreate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Huỷ',
                style: TextStyles.mediumRegularText
                    .copyWith(color: Palette.blue300, fontSize: 14.sp),
              ),
            ),
            Text(
              'Nhóm mới',
              style: TextStyles.largeBoldText.copyWith(color: Palette.blue300),
            ),
            TextButton(
              onPressed: onTapButtonCreate,
              child: Text(
                'Tạo',
                style: TextStyles.mediumRegularText
                    .copyWith(color: Palette.blue300, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
