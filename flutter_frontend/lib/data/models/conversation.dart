import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';

class Conversation {
  String id;
  String name;
  List<User> listUserIn;
  List<Message> listMessage;
  bool isRoom;

  Conversation({this.id, this.name, this.listUserIn, this.listMessage, this.isRoom = false});

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    listUserIn: List<User>.from((json["userIns"] as List<dynamic>).map((e) => User.fromMap(e["userIn"]))).toList(),
    listMessage: List<Message>.from((json["list_message"] as List<dynamic>).map((e) => Message.fromMap(e))).toList(),
  );

  factory Conversation.fromMapRoom(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    name: json["name"],
    listUserIn: List<User>.from((json["members"] as List<dynamic>).map((e) => User.fromMapRoom(e))).toList(),
    listMessage: List<Message>.from((json["list_message"] as List<dynamic>).map((e) => Message.fromMap(e))).toList(),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "_id": id,
    "name": name,
    "userIns": listUserIn,
    "list_message": listMessage,
  };
}