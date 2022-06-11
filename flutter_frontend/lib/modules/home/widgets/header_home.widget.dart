import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HeaderHome extends GetView<RootController> {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      width: size.width,
      height: 0.15 * size.height,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Palette.blue200,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            // top: MediaQuery.of(context).padding.top + 15,
            // bottom:
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: controller.openDrawer,
                padding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                icon: const Icon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                ),
              ),
              Text(
                'DUT Message',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.fontPoppins,
                  fontSize: ScreenUtil().setSp(21),
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(controller.currentUser.avatar),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
