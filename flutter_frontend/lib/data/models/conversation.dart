import 'package:flutter_frontend/core/constants/image_path.dart';
import 'package:flutter_frontend/data/models/message.dart';
import 'package:flutter_frontend/data/models/user.dart';

class Conversation {
  String id;
  String name;
  String avatarRoom;
  List<User> listUserIn;
  List<Message> listMessage;
  bool isRoom;

  Conversation({this.id, this.name, this.avatarRoom, this.listUserIn, this.listMessage = const <Message>[], this.isRoom = false});

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    listUserIn: List<User>.from((json["userIns"] as List<dynamic>).map((e) => User.fromMap(e["userIn"]))).toList(),
    listMessage: json["list_message"] == null ? <Message>[] : List<Message>.from((json["list_message"] as List<dynamic>).map((e) => Message.fromMap(e))).toList(),
  );

  factory Conversation.fromMapRoom(Map<String, dynamic> json) => Conversation(
    id: json["_id"],
    name: json["name"],
    avatarRoom: (json["avatar"] == null || json["avatar"] == "") ? ImagePath.avatarChatGroup : json["avatar"],
    listUserIn: List<User>.from((json["members"] as List<dynamic>).map((e) => User.fromMapRoom(e))).toList(),
    listMessage: List<Message>.from((json["list_message"] as List<dynamic>).map((e) => Message.fromMap(e))).toList(),
    isRoom: true,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    "_id": id,
    "name": name,
    "userIns": listUserIn,
    "list_message": listMessage,
  };

  @override
  String toString() {
    return "$id $listUserIn";
  }
}