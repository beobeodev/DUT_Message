import 'dart:convert';

class Message {
  String id;
  String author;
  String content;
  String status;
  List<String> deleteBy;

  Message({this.id, this.author, this.content, this.status, this.deleteBy});

  factory Message.fromJson(String str) => Message.fromMap(jsonDecode(str) as Map<String, dynamic>);

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    id: json["_id"],
    author: json["author"],
    content: json["content"].toString(),
    status: json["status"].toString(),
    deleteBy: json["deleteBy"] == null ? <String>[] : List<String>.from((json["deleteBy"] as List<dynamic>).map((dynamic x) => x.toString())).toList(),
  );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "_id": id,
    "author": author,
    "content": content,
    "status": status,
    "deleted_by": deleteBy,
  };
}