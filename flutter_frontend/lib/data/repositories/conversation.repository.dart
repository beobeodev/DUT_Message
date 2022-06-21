import 'package:flutter_frontend/data/datasources/remote/conversation.datasource.dart';
import 'package:flutter_frontend/data/models/conversation.model.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
// import 'package:http/http.dart' as http;

class ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepository({required this.remoteDataSource});

  Future<List<ConversationModel>> getFriendConversations() async {
    final List<dynamic> getFriendConversationsResponse =
        (await remoteDataSource.getFriendConversations()).data;

    final List<ConversationModel> result = getFriendConversationsResponse
        .map((e) => ConversationModel.fromJson(e))
        .toList();

    return result;
  }

  Future<List<ConversationModel>> getRoomConversations() async {
    final List<dynamic> getRoomConversationsResponse =
        (await remoteDataSource.getRoomConversations()).data;

    final List<ConversationModel> result = getRoomConversationsResponse
        .map((e) => ConversationModel.fromJsonRoom(e))
        .toList();

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
      final MessageModel messagePrevious = a.messages.last;
      final MessageModel messageAfter = b.messages.last;
      return messagePrevious.timeSend.compareTo(messageAfter.timeSend);
    });

    allConversationTemps = [
      ...friendConversationsWithEmptyMessage,
      ...allConversationTemps
    ];

    return allConversationTemps;
  }
}
