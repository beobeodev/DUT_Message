import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/data/models/user.model.dart';

class ConversationModel {
  String id;
  String name;
  String avatarRoom;
  List<UserModel> userIns;
  List<MessageModel> messages;
  bool isRoom;

  ConversationModel({
    required this.id,
    this.name = '',
    this.avatarRoom = '',
    this.userIns = const [],
    this.messages = const <MessageModel>[],
    this.isRoom = false,
  });

  MessageModel get lastMessage => messages.last;
  int get messageLength => messages.length;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['_id'],
        userIns: List<UserModel>.from(
          (json['userIns'] as List<dynamic>)
              .map((e) => UserModel.fromJson(e['userIn'])),
        ).toList(),
        messages: List<MessageModel>.from(
          (json['list_message'] as List<dynamic>)
              .map((e) => MessageModel.fromJson(e)),
        ).toList(),
      );

  factory ConversationModel.fromJsonRoom(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['_id'],
        name: json['name'],
        avatarRoom: json['avatar'],
        userIns: List<UserModel>.from(
          (json['members'] as List<dynamic>)
              .map((e) => UserModel.fromJson(e['member'])),
        ).toList(),
        messages: List<MessageModel>.from(
          (json['list_message'] as List<dynamic>)
              .map((e) => MessageModel.fromJson(e)),
        ).toList(),
        isRoom: true,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'name': name,
        'userIns': userIns,
        'list_message': messages,
      };

  @override
  String toString() {
    return '$id $userIns';
  }
}
