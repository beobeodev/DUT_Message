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
  List<String>? deleteBy;

  Message({
    required this.id,
    required this.author,
    required this.content,
    required this.status,
    this.isImage = false,
    this.isDeleted = false,
    required this.timeSend,
    this.deleteBy,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    String decryptMessage = json['content'].toString();
    if (!json['content'].toString().contains(' ')) {
      decryptMessage = EncryptMessage.decryptAES(json['content'].toString());
    }

    return Message(
      id: json['_id'].toString(),
      author: User.fromJson(json['author']),
      content: decryptMessage,
      status: json['status'].toString(),
      isImage: json['isImg'] as bool,
      isDeleted: json['deleted'] as bool,
      timeSend: DateTime.parse(json['createdAt'].toString()).toLocal(),
      deleteBy: (json['deleteBy'] as List<dynamic>?)
          ?.map((dynamic x) => x.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'author': author,
        'content': content,
        'status': status,
        'createdAt': timeSend,
        'deleted_by': deleteBy,
      };
}
