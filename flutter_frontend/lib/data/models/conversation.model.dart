import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:flutter_frontend/data/models/user.dart';

class ConversationModel {
  String id;
  String name;
  String avatarRoom;
  List<User> userIns;
  List<Message> messages;
  bool isRoom;

  ConversationModel({
    required this.id,
    this.name = '',
    this.avatarRoom = '',
    this.userIns = const [],
    this.messages = const <Message>[],
    this.isRoom = false,
  });

  Message get lastMessage => messages.last;
  int get messageLength => messages.length;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['_id'],
        userIns: List<User>.from(
          (json['userIns'] as List<dynamic>)
              .map((e) => User.fromJson(e['userIn'])),
        ).toList(),
        messages: List<Message>.from(
          (json['list_message'] as List<dynamic>)
              .map((e) => Message.fromJson(e)),
        ).toList(),
      );

  factory ConversationModel.fromJsonRoom(Map<String, dynamic> json) =>
      ConversationModel(
        id: json['_id'],
        name: json['name'],
        avatarRoom: json['avatar'],
        userIns: List<User>.from(
          (json['members'] as List<dynamic>).map((e) => User.fromJsonRoom(e)),
        ).toList(),
        messages: List<Message>.from(
          (json['list_message'] as List<dynamic>)
              .map((e) => Message.fromJson(e)),
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
