import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/drawer/drawer_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/custom/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HeaderHome extends StatelessWidget {
  final DrawerScreenController drawerController = Get.put(DrawerScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      width: size.width,
      height: 0.3 * size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Palette.crayolaBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: MediaQuery.of(context).padding.top + 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: drawerController.openDrawer,
                    icon: Icon(
                      FontAwesomeIcons.bars,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "DUT Message",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.fontPoppins,
                      fontSize: ScreenUtil().setSp(21),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(drawerController.currentUser.avatar),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              CustomTextFormField(
                width: double.infinity,
                height: ScreenUtil().setHeight(80),
                hintText: "Tìm kiếm người dùng",
                borderColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
