import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/enums/request_status.enum.dart';
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
  final Rx<RequestStatus> _getConversationsStatus = RequestStatus.done.obs;
  RequestStatus get getConversationsStatus => _getConversationsStatus.value;

  //Init data
  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
  }

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
      _getConversationsStatus.value = RequestStatus.loading;

      conversations.value = await conversationRepository.getAllConversations();

      _getConversationsStatus.value = RequestStatus.hasData;
    } on DioError catch (dioError) {
      _getConversationsStatus.value = RequestStatus.hasError;

      log('Error in getAllConversations() from HomeController ${dioError.response.toString()}');
      rethrow;
    } catch (e) {
      _getConversationsStatus.value = RequestStatus.hasError;

      log('Error in getAllConversations() from HomeController: ${e.toString()}');
      rethrow;
    }
  }

  void onTapConversationItem(String conversationId) {
    Get.toNamed(
      RouteManager.chat,
      arguments: conversationId,
    );
  }

  // * Listen receive message
  void onReceiveFriendConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveConversationMessage, (data) {
        final int conversationIndex = conversations
            .indexWhere((element) => element.id == data['converId']);

        final ConversationModel conversationTemp =
            conversations[conversationIndex];
        conversationTemp.messages.add(MessageModel.fromJson(data['message']));

        final List<ConversationModel> listTemp = List.from(conversations);
        listTemp.removeWhere((element) => element.id == data['converId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('Error in onReceiveConversationMessage(): $e');
      rethrow;
    }
  }

  void onReceiveRoomConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveRoomMessage, (data) {
        final int index =
            conversations.indexWhere((element) => element.id == data['roomId']);

        final ConversationModel conversationTemp = conversations[index];
        conversationTemp.messages.add(MessageModel.fromJson(data['message']));

        final List<ConversationModel> listTemp = List.from(conversations);
        listTemp.removeWhere((element) => element.id == data['roomId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('ERROR in onReceiveRoomMessage(): $e');
      rethrow;
    }
  }
  // *

  // * Listen create room conversation
  void onReceiveCreateRoomConversation() {
    try {
      rootController.socket.on(SocketEvent.receiveCreateRoom, (data) {
        rootController.socket.emit(SocketEvent.sendJoinRoom, {
          'fromId': authController.currentUser!.id,
          'roomId': data['_id'],
        });

        final ConversationModel roomConversation =
            ConversationModel.fromJsonRoom(data);
        conversations.value = [roomConversation, ...conversations];

        Get.offNamedUntil(
          RouteManager.chat,
          ModalRoute.withName(RouteManager.drawer),
          arguments: roomConversation.id,
        );
      });
    } catch (e) {
      log('Error in onReceiveCreateRoomConversation(): $e');
      rethrow;
    }
  }

  //* Listen remove message
  void onReceiveRemoveFriendConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveRemoveConversationMessage,
          (data) {
        final ConversationModel conversationTemp = conversations
            .firstWhere((element) => element.id == data['converId']);
        final MessageModel messageTemp = conversationTemp.messages
            .firstWhere((element) => element.id == data['messageId']);
        messageTemp.isDeleted = true;

        final List<ConversationModel> listTemp = List.from(conversations);
        listTemp.removeWhere((element) => element.id == data['converId']);

        conversations.value = [conversationTemp, ...listTemp];
      });
    } catch (e) {
      log('Error in onReceiveRemoveConversationMessage(): $e');
      rethrow;
    }
  }

  void onReceiveRemoveRoomConversationMessage() {
    try {
      rootController.socket.on(SocketEvent.receiveRemoveRoomMessage, (data) {
        // get current conversation and remove message
        final ConversationModel conversationTemp = conversations.firstWhere(
          (element) => element.id == data['roomId'],
        );
        final MessageModel messageTemp = conversationTemp.messages.firstWhere(
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
      rethrow;
    }
  }
  //*
}
