import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enums/request_status.enum.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/modules/home/controllers/home.controller.dart';
import 'package:flutter_frontend/modules/home/widgets/conversation_item.widget.dart';
import 'package:get/get.dart';

class ListConversation extends GetView<HomeController> {
  const ListConversation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Get.height * 0.15,
      width: Get.width,
      height: 0.85 * Get.height,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Palette.gray200,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Obx(() {
          return _buildGetConversations();
        }),
      ),
    );
  }

  Widget _buildGetConversations() {
    switch (controller.getConversationsStatus) {
      case RequestStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case RequestStatus.hasData:
        return Obx(
          () => ListView.builder(
            itemCount: controller.conversations.length,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
            ),
            itemBuilder: (context, index) {
              final ConversationModel currentConversation =
                  controller.conversations[index];
              if (currentConversation.messages.isNotEmpty) {
                return ConversationItem(
                  currentConversation: currentConversation,
                  onTap: () {
                    controller.onTapConversationItem(currentConversation.id);
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      case RequestStatus.hasError:
        return const Center(
          child: Text('Lỗi không thể lấy dữ liệu'),
        );
      default:
        return const SizedBox();
    }
  }
}
