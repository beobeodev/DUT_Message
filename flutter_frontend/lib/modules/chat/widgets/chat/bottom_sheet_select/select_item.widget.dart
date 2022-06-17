import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;

  const SelectItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.green,
        size: 30.sp,
      ),
      title: Text(
        title,
        style: TextStyles.largeBoldText.copyWith(fontSize: 16.sp),
      ),
      onTap: onTap,
    );
  }
}
