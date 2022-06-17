import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enums/message_type.enum.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/chat_item/file_content.widget.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/chat_item/image_content.widget.dart';
import 'package:flutter_frontend/modules/chat/widgets/chat/chat_item/text_content.widget.dart';

class ChatItemContent extends StatelessWidget {
  final MessageModel message;
  final bool isSender;
  final bool isRoomConversation;

  const ChatItemContent({
    Key? key,
    required this.message,
    required this.isSender,
    required this.isRoomConversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRoomConversation && !isSender)
            Text(
              message.author.name,
              style: const TextStyle(
                fontFamily: FontFamily.fontNunito,
                fontSize: 13,
                color: Palette.zodiacBlue,
              ),
            ),
          _buildContentMessage(),
        ],
      ),
    );
  }

  Widget _buildContentMessage() {
    if (message.isDeleted) {
      return TextContent(message: message, isSender: isSender);
    }

    switch (message.messageType) {
      case MessageType.text:
        return TextContent(message: message, isSender: isSender);
      case MessageType.image:
        return ImageContent(message: message);
      default:
        return FileContent(message: message, isSender: isSender);
    }
  }
}
