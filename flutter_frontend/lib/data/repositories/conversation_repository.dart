import 'dart:convert';

import 'package:flutter_frontend/core/constants/api_path.dart';
import 'package:flutter_frontend/data/models/conversation.dart';
import 'package:flutter_frontend/data/models/custom_response.dart';
import 'package:flutter_frontend/data/providers/http_provider.dart';
import 'package:http/http.dart' as http;

class ConversationRepository {

  static final ConversationRepository _singleton = ConversationRepository._init();

  factory ConversationRepository() {
    return _singleton;
  }

  ConversationRepository._init();

  Future<CustomResponse> getListConversation(String accessToken, String refreshToken, String idCurrentUser) async {
    try {
      final Map<String, String> header = {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "id": idCurrentUser,
      };

      final http.Response response = await HttpProvider.getRequest(ApiPath.conversationServerUrl, header: header);

      if (response.statusCode == 200) {
        final List<Conversation> listConversation = <Conversation>[];
        for (final element in jsonDecode(response.body)) {
          // print(element["userIns"]);
          listConversation.add(
            Conversation.fromMap(element),
          );
        }

        return CustomResponse(
          responseBody: {
            "result": listConversation,
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