import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/socket_event.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/data/repositories/conversation.repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ConversationRepository conversationRepository;

  final AuthController authController;
  final RootController rootController;

  HomeController({
    required this.authController,
    required this.conversationRepository,
    required this.rootController,
  });

  RxList<ConversationModel> conversations = <ConversationModel>[].obs;

  Future<void> getData() async {
    await getAllConversations();
    onReceiveFriendConversationMessage();
    onReceiveRoomConversationMessage();
    onReceiveCreateRoomConversation();
    onReceiveRemoveFriendConversationMessage();
    onReceiveRemoveRoomConversationMessage();
  }

  Future<void> getAllConversations() async {
    try {
      conversations.value = await conversationRepository.getAllConversations();
    } on DioError catch (dioError) {
      log(dioError.response.toString());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void onTapConversationItem(String conversationId) {
    Get.toNamed(
      RouteManager.chat,
      arguments: conversationId,
    );
  }

  void onReceiveFriendConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveConversationMessage, (data) {
        final int conversationIndex = conversations
            .indexWhere((element) => element.id == data['converId']);

        final ConversationModel conversationTemp =
            conversations[conversationIndex];
        conversationTemp.messages.add(Message.fromJson(data['message']));

        final List<ConversationModel> listTemp = List.from(conversations);
        listTemp.removeWhere((element) => element.id == data['converId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('Error in onReceiveConversationMessage(): $e');
    }
  }

  void onReceiveRoomConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveRoomMessage, (data) {
        final int index =
            conversations.indexWhere((element) => element.id == data['roomId']);

        final ConversationModel conversationTemp = conversations[index];
        conversationTemp.messages.add(Message.fromJson(data['message']));

        final List<ConversationModel> listTemp = List.from(conversations);
        listTemp.removeWhere((element) => element.id == data['roomId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('ERROR in onReceiveRoomMessage(): $e');
    }
  }

  void onReceiveCreateRoomConversation() {
    try {
      rootController.socket.on(SocketEvent.receiveCreateRoom, (data) {
        rootController.socket.emit(SocketEvent.sendJoinRoom, {
          'fromId': authController.currentUser!.id,
          'roomId': data['_id'],
        });

        final ConversationModel roomChat = ConversationModel.fromJsonRoom(data);
        conversations.value = [roomChat, ...conversations];

        Get.offNamedUntil(
          RouteManager.chat,
          ModalRoute.withName(RouteManager.drawer),
          arguments: [
            conversations.firstWhere((element) => element.id == roomChat.id),
            true
          ],
        );
      });
    } catch (e) {
      log('Error in onReceiveCreateRoom(): $e');
    }
  }

  void onReceiveRemoveFriendConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveRemoveConversationMessage,
          (data) {
        final ConversationModel conversationTemp = conversations
            .firstWhere((element) => element.id == data['converId']);
        final Message messageTemp = conversationTemp.messages
            .firstWhere((element) => element.id == data['messageId']);
        messageTemp.isDeleted = true;

        final List<ConversationModel> listTemp = List.from(conversations);
        listTemp.removeWhere((element) => element.id == data['converId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('Error in onReceiveRemoveConversationMessage(): $e');
    }
  }

  void onReceiveRemoveRoomConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveRemoveRoomMessage, (data) {
        // get current conversation and remove message
        final ConversationModel conversationTemp = conversations.firstWhere(
          (element) => element.id == data['roomId'],
        );
        final Message messageTemp = conversationTemp.messages.firstWhere(
          (element) => element.id == data['messageId'],
        );

        messageTemp.isDeleted = true;
        final List<ConversationModel> listTemp = List.from(
          conversations,
        );
        listTemp.removeWhere((element) => element.id == data['roomId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('Error in onReceiveRemoveRoomMessage(): $e');
    }
  }
}
