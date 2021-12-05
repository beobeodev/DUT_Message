import 'dart:convert';

import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/providers/http_provider.dart';
import 'package:flutter_frontend/data/repositories/local_repository.dart';
import 'package:http/http.dart' as http;

class ConversationRepository {
  final LocalRepository localRepository = LocalRepository();

  static final ConversationRepository _singleton = ConversationRepository._init();

  factory ConversationRepository() {
    return _singleton;
  }

  List<Conversation> listConversation;
  List<Conversation> listRoom;
  List<Conversation> listConversationAndRoom;

  ConversationRepository._init();

  Future<CustomResponse> getListConversation() async {
    try {
      final Map<String, String> header = {
        "accessToken": localRepository.accessToken,
        "refreshToken": localRepository.refreshToken,
        "id": localRepository.infoCurrentUser.id,
      };

      final http.Response response = await HttpProvider.getRequest(ApiPath.conversationServerUrl, header: header);

      // print("in getListConversation() from CONVERSATION REPOSITORY: ${response.body}");

      if (response.statusCode == 200) {
        final List<Conversation> listConversationTemp = <Conversation>[];
        for (final element in jsonDecode(response.body)) {
          // print(element);
          listConversationTemp.add(
            Conversation.fromMap(element),
          );
        }

        listConversation = listConversationTemp;

        return CustomResponse(
          responseBody: {
            "result": listConversationTemp,
          },
        );
      } else if (response.statusCode == 500) {
        listConversation = <Conversation>[];
        return CustomResponse(
          statusCode: 500,
          error: true,
          errorMaps: {
            "message": "internal server error",
          },
        );
      }
    } catch (err) {
      print("Error in getListConversation() from ConversationRepository: $err");
      return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
          "message": err,
        },
      );
    }
    return CustomResponse(
      statusCode: 500,
      error: true,
      errorMaps: {
        "message": "invalid request",
      },
    );
  }

  Future<CustomResponse> getListRoom() async {
    try {
      final Map<String, String> header = {
        "accessToken": localRepository.accessToken,
        "refreshToken": localRepository.refreshToken,
        "id": localRepository.infoCurrentUser.id,
      };

      final http.Response response = await HttpProvider.getRequest(ApiPath.roomServerUrl, header: header);

      // print("in getListConversation() from CONVERSATION REPOSITORY: ${response.body}");

      if (response.statusCode == 200) {
        final List<Conversation> listConversationRoomTemp = <Conversation>[];
        for (final element in jsonDecode(response.body)) {
          // print(element);
          listConversationRoomTemp.add(
            Conversation.fromMapRoom(element),
          );
        }

        listRoom = listConversationRoomTemp;

        return CustomResponse(
          responseBody: {
            "result": listConversationRoomTemp,
          },
        );
      } else if (response.statusCode == 500) {
        listConversation = <Conversation>[];
        return CustomResponse(
          statusCode: 500,
          error: true,
          errorMaps: {
            "message": "internal server error",
          },
        );
      }
    } catch (err) {
      print("Error in getListRoom() from ConversationRepository: $err");
      return CustomResponse(
        statusCode: 500,
        error: true,
        errorMaps: {
          "message": err,
        },
      );
    }
    return CustomResponse(
      statusCode: 500,
      error: true,
      errorMaps: {
        "message": "invalid request",
      },
    );
  }

  Future<void> getListConversationAndRoom() async {
    try {
      await getListConversation();
      await getListRoom();
      final List<Conversation> listMessageEmpty = List.from(listConversation.where((element) => element.listMessage.isEmpty).toList());
      List<Conversation> listConversationAndRoomTemp = <Conversation>[...listConversation.where((element) => element.listMessage.isNotEmpty).toList(), ...listRoom];
      listConversationAndRoomTemp.sort((a, b) {
        final Message messagePrevious = a.listMessage.last;
        final Message messageAfter = b.listMessage.last;
        return messagePrevious.timeSend.compareTo(messageAfter.timeSend);
      });
      listConversationAndRoomTemp = [...listMessageEmpty, ...listConversationAndRoomTemp.reversed];
      for (final element in listConversationAndRoomTemp) {
        print(element.id);
      }
      listConversationAndRoom = listConversationAndRoomTemp;
    } catch (e) {
      print("Error in getListConversationAndRoom() from ConversationRepository: $e");
    }
  }
}