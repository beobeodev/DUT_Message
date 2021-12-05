import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/home/home_controller.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListConversationWidget extends StatelessWidget {
  final HomeController homeController;

  const ListConversationWidget({Key key, this.homeController}) : super(key: key);

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
                itemCount: homeController.listConversationAndRoom.length,
                padding: EdgeInsets.only(
                  top: 0.1,
                ),
                itemBuilder: (context, index) {
                  if (homeController.listConversationAndRoom[index].listMessage.isNotEmpty) {
                    // get info of user who is chatting
                    final User friend = homeController.listConversationAndRoom[index].listUserIn.firstWhere((element) => homeController.currentUser.id != element.id);
                    // show name of CONVERSATION, if conversation IS ROOM
                    // => SHOW ROOM NAME
                    String conversationName = friend.name;
                    // show AVATAR OF CONVERSATION, if conversation IS ROOM
                    // => SHOW AVATAR OF ROOM
                    // ELSE => SHOW AVATAR OF FRIEND
                    String avatar = friend.avatar;

                    final int indexLast = homeController.listConversationAndRoom[index].listMessage.length - 1;
                    // get latest message of conversation to show in view
                    final Message lastMessage = homeController.listConversationAndRoom[index].listMessage[indexLast];
                    // check if last message is image
                    // => SHOW TEXT "ĐÃ GỬI MỘT TỆP ĐÍNH KÈM"
                    final bool isImage = homeController.listConversationAndRoom[index].listMessage[indexLast].isImage;
                    // check if CURRENT CONVERSATION IS ROOM MESSAGE
                    final bool isRoom = homeController.listConversationAndRoom[index].isRoom;

                    if (isRoom) {
                      conversationName = homeController.listConversationAndRoom[index].name;
                      avatar = homeController.listConversationAndRoom[index].avatarRoom;
                    }
                    // this variable to show latest content of message
                    // in current conversation
                    String lastText = "Bạn: ${lastMessage.content}";
                    if (lastMessage.author.id == homeController.currentUser.id) {
                      if (isImage) {
                        lastText = "Bạn đã gửi một tệp đính kèm";
                      } else {
                        lastText = "Bạn: ${lastMessage.content}";
                      }
                    } else {
                      if (isRoom) {
                        if (isImage) {
                          lastText = "${lastMessage.author.name}: đã gửi một tệp đính kèm";
                        } else {
                          lastText = "${lastMessage.author.name}: ${lastMessage.content}";
                        }
                      } else {
                        if (isImage) {
                          lastText = "Đã gửi một tệp đính kèm";
                        } else {
                          lastText = lastMessage.content;
                        }
                      }
                    }

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
                              backgroundImage: NetworkImage(avatar),
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
                                    conversationName,
                                    style: TextStyle(
                                      color: Palette.zodiacBlue,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: FontFamily.fontNunito,
                                      fontSize: ScreenUtil().setSp(17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    lastText,
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
