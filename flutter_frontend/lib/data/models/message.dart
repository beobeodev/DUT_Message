import 'dart:convert';

import 'package:flutter_frontend/data/models/user.dart';

class Message {
  User author;
  String content;
  String status;
  List<User> deleteBy;

  Message({this.author, this.content, this.status, this.deleteBy});

  factory Message.fromJson(String str) => Message.fromMap(jsonDecode(str) as Map<String, dynamic>);

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    author: json["author"],
    content: json["content"].toString(),
    status: json["status"].toString(),
    deleteBy: json["deleteBy"] == null ? <User>[] : List<User>.from((json["deleteBy"] as List<dynamic>).map((dynamic x) => User.fromMap(x))).toList(),
  );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "author": author,
    "content": content,
    "status": status,
    "deleted_by": deleteBy,
  };
}