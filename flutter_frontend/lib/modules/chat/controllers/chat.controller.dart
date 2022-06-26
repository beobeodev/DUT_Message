import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enums/message_type.enum.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/core/utils/encrypt_message.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/bottom_sheet_select/bottom_sheet_select.widget.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/focus_menu/focus_menu.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/focus_menu/focus_menu_item.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/file_repository.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_frontend/widgets/rounded_alert_dialog.widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FileRepository fileRepository;
  final AuthController authController;
  final HomeController homeController;
  final RootController rootController;

  ChatController({
    required this.authController,
    required this.fileRepository,
    required this.homeController,
    required this.rootController,
  });

  final String conversationId = Get.arguments;
  ConversationModel get currentConversation {
    return homeController.conversations
        .firstWhere((element) => element.id == conversationId);
  }

  bool get isRoomConversation => currentConversation.isRoom;

  final ScrollController messageScrollController = ScrollController();
  final TextEditingController inputTextController = TextEditingController();

  late UserModel friendUser;

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
      if (messageScrollController.hasClients) {
        messageScrollController
            .jumpTo(messageScrollController.position.maxScrollExtent);
      }
    });
    messageScrollController
        .jumpTo(messageScrollController.position.maxScrollExtent);
    homeController.conversations.listen(
      (p0) {
        Timer(
          const Duration(milliseconds: 200),
          () => {
            if (messageScrollController.hasClients)
              {
                messageScrollController
                    .jumpTo(messageScrollController.position.maxScrollExtent)
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
        emitSendRoomConversationMessage(content: inputTextController.text);
      } else {
        emitSendFriendConversationMessage(content: inputTextController.text);
      }
      inputTextController.clear();
    }
  }

  void emitSendRoomConversationMessage({
    required String content,
    String messageType = MessageType.text,
  }) {
    try {
      final String encryptContent = EncryptMessage.encryptAES(content);

      rootController.socket.emit(SocketEvent.sendRoomMessage, {
        'roomId': currentConversation.id,
        'content': encryptContent,
        'fromUserId': authController.currentUser!.id,
        'message_type': messageType,
      });
    } catch (e) {
      log('Error in emitSendRoomMessage(): $e');
    }
  }

  void emitSendFriendConversationMessage({
    required String content,
    String messageType = MessageType.text,
  }) {
    try {
      final String encryptContent = EncryptMessage.encryptAES(content);

      rootController.socket.emit(SocketEvent.sendConversationMessage, {
        'converId': currentConversation.id,
        'fromUserId': authController.currentUser!.id,
        'toUserId': friendUser.id,
        'content': encryptContent,
        'message_type': messageType,
      });
    } catch (e) {
      log('Error in emitSendConversationMessage(): $e');
    }
  }

  Future<void> showFilePicker(FileType fileType) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);

    if (result != null) {
      final File file = File(result.files.single.path!);
      final int sizeInBytes = file.lengthSync();
      final double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 15) {
        Get.dialog(
          const RoundedAlertDialog(
            icon: FontAwesomeIcons.exclamationTriangle,
            iconColor: Colors.yellow,
            content: 'Vui lòng chọn tệp có kích thước nhỏ hơn 15 MB!',
          ),
        );
      } else {
        final String url =
            await fileRepository.uploadToFireStorage(fileType, file);
        if (isRoomConversation) {
          emitSendRoomConversationMessage(
            content: url,
            messageType: fileType.name,
          );
        } else {
          emitSendFriendConversationMessage(
            content: url,
            messageType: fileType.name,
          );
        }
      }
    }
  }

  Future<void> showSelectModalBottom() async {
    await showModalBottomSheet(
      context: Get.context!,
      barrierColor: Colors.black26,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SelectBottomSheet(
          onPressItem: showFilePicker,
        );
      },
    );
  }

  void openMenuChatScreen() {
    if (isRoomConversation) {
      Get.toNamed(RouteManager.menuChat, arguments: currentConversation);
    } else {
      Get.toNamed(RouteManager.menuChat, arguments: friendUser);
    }
  }

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

  Future<void> onOpenFocusMenu(
    GlobalKey testKey, {
    bool isFile = false,
    bool isSender = true,
    String? urlDownload,
    required String messageId,
  }) async {
    final RenderBox renderBox =
        testKey.currentContext?.findRenderObject() as RenderBox;
    final Offset childOffset = renderBox.localToGlobal(Offset.zero);

    final Size childSize = renderBox.size;

    const double menuWidth = 200;
    const double menuHeight = 100;

    final leftMargin = (childOffset.dx + menuWidth) < Get.width
        ? childOffset.dx + 10
        : (Get.width - menuWidth - 10);
    final topMargin =
        (childOffset.dy + menuHeight + childSize.height + 50) < Get.height
            ? childOffset.dy + childSize.height + 8
            : childOffset.dy - menuHeight;

    await Navigator.of(Get.context!).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 100),
        barrierDismissible: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: FocusMenu(
              leftMargin: leftMargin,
              topMargin: topMargin,
              focusMenuItems: <FocusMenuItem>[
                // if (isSender)
                FocusMenuItem(
                  title: isSender ? 'Gỡ tin nhắn' : 'Xoá tin nhắn',
                  icon: FontAwesomeIcons.trash,
                  onTapItem: () {
                    removeMessage(messageId);

                    Get.back();
                  },
                ),
                if (isFile)
                  FocusMenuItem(
                    title: 'Tải về',
                    icon: FontAwesomeIcons.download,
                    onTapItem: () async {
                      Get.back();

                      await implementDownload(urlDownload!);
                    },
                  ),
              ],
            ),
          );
        },
        opaque: false,
      ),
    );
  }

  // Future<bool> _requestPermissions() async {
  //   Permission permission = Permission.storage;

  //   if (!(await permission.isGranted)) {
  //     await Permission.storage.request();
  //     permission = Permission.storage;
  //   }

  //   final bool check = await permission.isGranted;

  //   return check;
  // }

  Future<void> implementDownload(String url) async {
    try {
      await fileRepository.downloadFile(url);
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Lưu thành công',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      log('Error in implementDownload() from ChatController: $e');
    }
  }
}
