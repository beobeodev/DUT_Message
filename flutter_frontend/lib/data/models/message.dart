import 'dart:convert';

import 'package:flutter_frontend/core/utils/encrypt_message.dart';
import 'package:flutter_frontend/data/models/user.dart';

class Message {
  String id;
  User author;
  String content;
  String status;
  bool isImage;
  bool isDeleted;
  DateTime timeSend;
  List<String> deleteBy;

  Message({this.id, this.author, this.content, this.status, this.isImage = false, this.isDeleted = false ,this.timeSend, this.deleteBy});

  factory Message.fromJson(String str) => Message.fromMap(jsonDecode(str) as Map<String, dynamic>);

  factory Message.fromMap(Map<String, dynamic> json) {
    String decryptMessage = json["content"].toString();
    if (!json["content"].toString().contains(" ")) {
      decryptMessage = EncryptMessage.decryptAES(json["content"].toString());
    }

    return Message(
      id: json["_id"].toString(),
      author: User.fromMap(json["author"]),
      content: decryptMessage,
      status: json["status"].toString(),
      isImage: json["isImg"] as bool,
      isDeleted: json["deleted"] as bool,
      timeSend: DateTime.parse(json["createdAt"].toString()).toLocal(),
      deleteBy: json["deleteBy"] == null ? <String>[] : List<String>.from((json["deleteBy"] as List<dynamic>).map((dynamic x) => x.toString())).toList(),
    );
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "_id": id,
    "author": author,
    "content": content,
    "status": status,
    "createdAt": timeSend,
    "deleted_by": deleteBy,
  };
}