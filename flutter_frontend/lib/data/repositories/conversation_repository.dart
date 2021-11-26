import 'dart:convert';

import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
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

  ConversationRepository._init();

  Future<CustomResponse> getListConversation() async {
    try {
      final Map<String, String> header = {
        "accessToken": localRepository.accessToken,
        "refreshToken": localRepository.refreshToken,
        "id": localRepository.infoCurrentUser.id,
      };

      final http.Response response = await HttpProvider.getRequest(ApiPath.conversationServerUrl, header: header);

      if (response.statusCode == 200) {
        final List<Conversation> listConversationTemp = <Conversation>[];
        for (final element in jsonDecode(response.body)) {
          // print(element["userIns"]);
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
}