import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListMessage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.3,
      width: size.width,
      height: 0.7 * size.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
          ),
          child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.only(
                top: 0.0,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 6.0,
                  ),
                  child: GestureDetector(
                    onTap: homeController.onTapMessage,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Palette.americanSilver,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: ScreenUtil().setHeight(65),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://yt3.ggpht.com/ytc/AKedOLQ6aeVpATJCBdgFA8uBSwIuvI0sVGiZ7LSwnqBT=s900-c-k-c0x00ffffff-no-rj'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Quốc Đạt",
                                      style: TextStyle(
                                        color: Palette.zodiacBlue,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: FontFamily.fontNunito,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Mi push code lên chưa?",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: FontFamily.fontNunito,
                                        fontSize: ScreenUtil().setSp(15),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
          ),
        ),
      ),
    );
  }
}