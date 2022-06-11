import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/core/utils/encrypt_message.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/user.dart';
import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseRepository firebaseRepository;
  final AuthController authController;
  final HomeController homeController;
  final RootController rootController;

  ChatController({
    required this.authController,
    required this.firebaseRepository,
    required this.homeController,
    required this.rootController,
  });

  final String conversationId = Get.arguments;
  ConversationModel get currentConversation {
    return homeController.conversations
        .firstWhere((element) => element.id == conversationId);
  }

  bool get isRoomConversation => currentConversation.isRoom;

  final ScrollController scrollController = ScrollController();
  final TextEditingController inputTextController = TextEditingController();

  late User friendUser;

  @override
  void onInit() {
    super.onInit();
    if (!currentConversation.isRoom) {
      friendUser = currentConversation.userIns.firstWhere(
        (element) => element.id != authController.currentUser!.id,
      );
    }
    // homeController.conversations.listen((p0) {
    //   currentConversation.update((val) {
    //     val = p0.firstWhere(
    //       (element) => element.id == currentConversation.value.id,
    //     );
    //   });
    // });
    // print(currentConversation.value.listMessage.length);
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    homeController.conversations.listen(
      (p0) {
        Timer(
          const Duration(milliseconds: 200),
          () => {
            if (scrollController.hasClients)
              {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent)
              }
          },
        );
      },
    );
  }

  void onTapBackIcon() {
    Get.back();
  }

  void onTapButtonSendMessage() {
    if (inputTextController.text != '') {
      if (isRoomConversation) {
        emitSendRoomConversationMessage();
      } else {
        emitSendFriendConversationMessage();
      }
      inputTextController.clear();
    }
  }

  void emitSendRoomConversationMessage({
    bool isImg = false,
  }) {
    try {
      final String encryptContent =
          EncryptMessage.encryptAES(inputTextController.text);

      rootController.socket.emit(SocketEvent.sendRoomMessage, {
        'roomId': currentConversation.id,
        'content': encryptContent,
        'fromUserId': authController.currentUser!.id,
        'isImg': isImg,
      });
    } catch (e) {
      log('ERROR in emitSendRoomMessage(): $e');
    }
  }

  void emitSendFriendConversationMessage({
    bool isImg = false,
  }) {
    try {
      final String encryptContent =
          EncryptMessage.encryptAES(inputTextController.text);

      rootController.socket.emit(SocketEvent.sendConversationMessage, {
        'converId': currentConversation.id,
        'fromUserId': authController.currentUser!.id,
        'toUserId': friendUser.id,
        'content': encryptContent,
        'isImg': isImg,
      });
    } catch (e) {
      log('Error in emitSendConversationMessage(): $e');
    }
  }

  // Future<void> showFilePicker(FileType fileType) async {
  //   final FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(type: fileType);
  //   if (result != null) {
  //     final File file = File(result.files.single.path!);
  //     final int sizeInBytes = file.lengthSync();
  //     final double sizeInMb = sizeInBytes / (1024 * 1024);
  //     if (sizeInMb > 15) {
  //       Get.dialog(
  //         AlertDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           content: Wrap(
  //             alignment: WrapAlignment.center,
  //             crossAxisAlignment: WrapCrossAlignment.center,
  //             direction: Axis.vertical,
  //             children: [
  //               Icon(
  //                 FontAwesomeIcons.exclamationTriangle,
  //                 color: Colors.yellow,
  //                 size: ScreenUtil().setSp(72),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Text(
  //                 'Vui lòng chọn tệp có kích thước nhỏ hơn 15 MB!',
  //                 style: TextStyle(
  //                   fontFamily: FontFamily.fontNunito,
  //                   color: Palette.zodiacBlue,
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: ScreenUtil().setSp(25),
  //                 ),
  //                 textAlign: TextAlign.center,
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     } else {
  //       final String url =
  //           await firebaseRepository.uploadToFireStorage(fileType, file);
  //       if (isRoom) {
  //         socketController.emitSendRoomConversationMessage(
  //           roomId: currentConversation.id,
  //           content: url,
  //           isImg: true,
  //         );
  //       } else {
  //         socketController.emitSendFriendConversationMessage(
  //           conversationId: currentConversation.id,
  //           fromId: localRepository.currentUser.id,
  //           toId: friendUser.id,
  //           content: url,
  //           isImg: true,
  //         );
  //       }
  //     }
  //   }
  // }

  // Future<void> showSelectModalBottom() async {
  //   await showModalBottomSheet(
  //     context: Get.context!,
  //     barrierColor: Colors.black26,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return SelectBottomSheet(
  //         onPressItem: showFilePicker,
  //       );
  //     },
  //   );
  // }

  void openMenuChatScreen() {
    if (isRoomConversation) {
      Get.toNamed(RouteManager.menuChat, arguments: currentConversation);
    } else {
      Get.toNamed(RouteManager.menuChat, arguments: friendUser);
    }
  }

  // this function to handle event 'GỚ TIN NHẮN'
  void removeMessage(String messageId) {
    if (isRoomConversation) {
      sendRemoveRoomConversationMessage(
        messageId,
      );
    } else {
      sendRemoveFriendConversationMessage(
        messageId,
      );
    }
  }

  void sendRemoveRoomConversationMessage(String messageId) {
    try {
      rootController.socket.emit(SocketEvent.sendRemoveRoomMessage, {
        'roomId': currentConversation.id,
        'messageId': messageId,
      });
    } catch (e) {
      log('Error in sendRemoveConversationMessage(): $e');
    }
  }

  void sendRemoveFriendConversationMessage(String messageId) {
    try {
      rootController.socket.emit(SocketEvent.sendRemoveConversationMessage, {
        'messageId': messageId,
        'fromId': authController.currentUser!.id,
        'toId': friendUser.id,
        'converId': currentConversation.id,
      });
    } catch (e) {
      log('Error in sendRemoveConversationMessage(): $e');
    }
  }

  //
  // Future<void> onOpenFocusMenu(
  //   GlobalKey testKey, {
  //   bool isFile = false,
  //   bool isSender = true,
  //   String? urlDownload,
  //   required String messageId,
  // }) async {
  //   Offset childOffset = const Offset(0, 0);
  //   Size childSize;
  //   final RenderBox renderBox =
  //       testKey.currentContext?.findRenderObject() as RenderBox;
  //   final Size size = renderBox.size;
  //   final Offset offset = renderBox.localToGlobal(Offset.zero);
  //   childOffset = Offset(offset.dx, offset.dy);
  //   childSize = size;

  //   const double menuWidth = 200;
  //   const double menuHeight = 100;

  //   final leftMargin = (childOffset.dx + menuWidth) < ScreenUtil().screenWidth
  //       ? childOffset.dx + 10
  //       : (ScreenUtil().screenWidth - menuWidth - 20);
  //   final topMargin = (childOffset.dy + menuHeight + childSize.height + 50) <
  //           ScreenUtil().screenHeight
  //       ? childOffset.dy + childSize.height + 8
  //       : childOffset.dy - menuHeight;

  //   await Navigator.of(Get.context!).push(
  //     PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 100),
  //       barrierDismissible: true,
  //       pageBuilder: (context, animation, secondaryAnimation) {
  //         return FadeTransition(
  //           opacity: animation,
  //           child: FocusMenuDetail(
  //             leftMargin: leftMargin,
  //             topMargin: topMargin,
  //             listFocusMenuItem: <FocusMenuItem>[
  //               if (isSender)
  //                 FocusMenuItem(
  //                   title: Text(
  //                     isSender ? 'Gỡ tin nhắn' : 'Xoá tin nhắn',
  //                     style: TextStyle(
  //                       color: Palette.zodiacBlue,
  //                       fontFamily: FontFamily.fontNunito,
  //                       fontSize: ScreenUtil().setSp(13),
  //                     ),
  //                   ),
  //                   icon: const Icon(
  //                     FontAwesomeIcons.trash,
  //                     color: Colors.red,
  //                     size: 18,
  //                   ),
  //                   onTapItem: () {
  //                     removeMessage(messageId);
  //                     Get.back();
  //                   },
  //                 ),
  //               if (isFile)
  //                 FocusMenuItem(
  //                   title: Text(
  //                     'Tải về',
  //                     style: TextStyle(
  //                       color: Palette.zodiacBlue,
  //                       fontFamily: FontFamily.fontNunito,
  //                       fontSize: ScreenUtil().setSp(13),
  //                     ),
  //                   ),
  //                   icon: const Icon(
  //                     FontAwesomeIcons.download,
  //                     color: Palette.metallicViolet,
  //                     size: 18,
  //                   ),
  //                   onTapItem: () async {
  //                     await implementDownload(urlDownload);
  //                   },
  //                 ),
  //             ],
  //           ),
  //         );
  //       },
  //       fullscreenDialog: true,
  //       opaque: false,
  //     ),
  //   );
  // }

  // Future<bool> _requestPermissions() async {
  //   Permission permission = Permission.storage;

  //   if (!(await permission.isGranted)) {
  //     await Permission.storage.request();
  //     permission = Permission.storage;
  //   }

  //   final bool check = await permission.isGranted;

  //   return check;
  // }

  // Future<void> implementDownload(String? url) async {
  //   try {
  //     Directory? path;
  //     if (Platform.isIOS) {
  //       path = await getApplicationDocumentsDirectory();
  //     } else {
  //       path = await getExternalStorageDirectory();
  //     }
  //     // final String _localPath = '${_path.absolute.path}${Platform.pathSeparator}Download';
  //     // final savedDir = Directory(_localPath);
  //     // final bool hasExisted = await savedDir.exists();
  //     // if (!hasExisted) {
  //     //   savedDir.create();
  //     // }

  //     // print(savedDir.path);
  //     final status = await Permission.storage.request();

  //     if (status.isGranted) {
  //       final String? taskId = await FlutterDownloader.enqueue(
  //         url: url!,
  //         savedDir: path!.path,
  //         saveInPublicStorage: true,
  //       );
  //     } else {
  //       print('Permission denied!');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   print('DOWNLOAD FILE SUCCESSFUL!!');
  //   Get.back();
  // }
}
