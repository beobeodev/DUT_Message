import 'package:flutter_frontend/core/utils/encrypt_message.dart';
import 'package:flutter_frontend/data/models/user.model.dart';

class MessageModel {
  String id;
  UserModel author;
  String content;
  String messageType;
  bool deleted;
  bool isNotify;
  DateTime timeSend;
  List<String>? deleteBy;

  MessageModel({
    required this.id,
    required this.author,
    required this.content,
    required this.messageType,
    this.deleted = false,
    this.isNotify = false,
    required this.timeSend,
    this.deleteBy,
  });

  String get realContent {
    if (deleted) {
      return 'Đã gỡ tin nhắn';
    }
    if (!content.contains(' ')) {
      return EncryptMessage.decryptAES(content);
    }
    return content;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] as String,
      author: UserModel.fromJson(json['author']),
      content: json['content'] as String,
      messageType: json['message_type'] as String,
      deleted: json['deleted'] as bool,
      isNotify: json['isNotify'] as bool,
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
        'createdAt': timeSend,
        'deleted_by': deleteBy,
      };
}
