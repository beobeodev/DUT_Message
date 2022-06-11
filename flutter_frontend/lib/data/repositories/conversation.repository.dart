import 'package:flutter_frontend/core/utils/dio/dio_provider.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
// import 'package:http/http.dart' as http;

class ConversationRepository {
  final HiveLocalRepository localRepository;

  // late List<ConversationModel> listConversation;
  // late List<ConversationModel> listRoom;
  // late List<ConversationModel> listConversationAndRoom;

  ConversationRepository({required this.localRepository});

  Future<List<ConversationModel>> getFriendConversations() async {
    final Map<String, String> header = {
      'accessToken': localRepository.accessToken!,
      'refreshToken': localRepository.refreshToken!,
      'id': localRepository.currentUser!.id,
    };

    final List<dynamic> rawData =
        await DioProvider.get(url: '/conversation', headers: header);

    final List<ConversationModel> result =
        rawData.map((e) => ConversationModel.fromJson(e)).toList();
    return result;
  }

  Future<List<ConversationModel>> getRoomConversations() async {
    final Map<String, String> header = {
      'accessToken': localRepository.accessToken!,
      'refreshToken': localRepository.refreshToken!,
      'id': localRepository.currentUser!.id,
    };

    final List<dynamic> rawData =
        await DioProvider.get(url: '/room', headers: header);

    final List<ConversationModel> result =
        rawData.map((e) => ConversationModel.fromJsonRoom(e)).toList();
    return result;
  }

  Future<List<ConversationModel>> getAllConversations() async {
    final List<ConversationModel> friendConversations =
        await getFriendConversations();
    final List<ConversationModel> roomConversations =
        await getRoomConversations();

    final List<ConversationModel> friendConversationsWithEmptyMessage =
        List.from(
      friendConversations.where((element) => element.messages.isEmpty),
    );

    List<ConversationModel> allConversationTemps = <ConversationModel>[
      ...friendConversations.where((element) => element.messages.isNotEmpty),
      ...roomConversations
    ];

    allConversationTemps.sort((b, a) {
      final Message messagePrevious = a.messages.last;
      final Message messageAfter = b.messages.last;
      return messagePrevious.timeSend.compareTo(messageAfter.timeSend);
    });

    allConversationTemps = [
      ...friendConversationsWithEmptyMessage,
      ...allConversationTemps
    ];

    return allConversationTemps;
  }
}
