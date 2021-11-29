import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListConversation extends StatelessWidget {
  final HomeController homeController;

  const ListConversation({Key key, this.homeController}) : super(key: key);

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
          child: Obx(
            () => ListView.builder(
                itemCount: homeController.listConversation.length,
                padding: EdgeInsets.only(
                  top: 0.1,
                ),
                itemBuilder: (context, index) {
                  if (homeController.listConversation[index].listMessage.isNotEmpty) {
                    final User friend = homeController.listConversation[index].listUserIn.firstWhere((element) => homeController.currentUser.id != element.id);
                    final String friendName = friend.name;
                    final String friendAvatar = friend.avatar;
                    final int indexLast = homeController.listConversation[index].listMessage.length - 1;
                    final Message lastMessage = homeController.listConversation[index].listMessage[indexLast];
                    final bool isImage = homeController.listConversation[index].listMessage[indexLast].isImage;
                    return GestureDetector(
                      onTap: () {
                        homeController.onTapConversation(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.americanSilver,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: ScreenUtil().setHeight(65),
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 5,
                          bottom: 5,
                        ),
                        margin: EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(friendAvatar),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    friendName,
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
                                    lastMessage.author.id == homeController.currentUser.id ? (isImage ? "Bạn: đã gửi một file" : "Bạn: ${lastMessage.content}") : (isImage ? "Đã gửi một file" : lastMessage.content),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: lastMessage.author.id == homeController.currentUser.id ? Colors.white : Colors.black,
                                      fontWeight: lastMessage.author.id == homeController.currentUser.id ? FontWeight.w400 : FontWeight.w700,
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
                    );
                  } else {
                    return const SizedBox();
                  }
                },
            ),
          ),
        ),
      ),
    );
  }
}
