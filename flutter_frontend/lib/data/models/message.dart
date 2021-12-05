import 'dart:convert';

import 'package:flutter_frontend/data/models/user.dart';

class Message {
  String id;
  User author;
  String content;
  String status;
  bool isImage;
  DateTime timeSend;
  List<String> deleteBy;

  Message({this.id, this.author, this.content, this.status, this.isImage = false ,this.timeSend, this.deleteBy});

  factory Message.fromJson(String str) => Message.fromMap(jsonDecode(str) as Map<String, dynamic>);

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    id: json["_id"].toString(),
    author: User.fromMap(json["author"]),
    content: json["content"].toString(),
    status: json["status"].toString(),
    isImage: json["isImg"] as bool,
    timeSend: DateTime.parse(json["createdAt"].toString()).toLocal(),
    deleteBy: json["deleteBy"] == null ? <String>[] : List<String>.from((json["deleteBy"] as List<dynamic>).map((dynamic x) => x.toString())).toList(),
  );

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