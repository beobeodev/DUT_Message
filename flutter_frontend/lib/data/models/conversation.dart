import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';

class Conversation {
  String id;
  List<User> listUserIn;
  List<Message> listMessage;

  Conversation({this.id, this.listUserIn, this.listMessage});

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    listUserIn: List<User>.from((json["userIns"] as List<dynamic>).map((e) => User.fromMap(e["userIn"]))).toList(),
    listMessage: List<Message>.from((json["list_message"] as List<dynamic>).map((e) => Message.fromMap(e))).toList(),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "userIns": listUserIn,
    "list_message": listMessage,
  };
}