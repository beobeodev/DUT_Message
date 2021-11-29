import 'package:flutter/cupertino.dart';

class FriendRequest {
  String friendRequestId;
  String fromId;
  String toId;
  String name;
  String avatar;

  FriendRequest({@required this.friendRequestId, @required this.fromId, @required this.toId, @required this.name, @required this.avatar});

  // factory FriendRequest.fromMap(Map<String, dynamic> data) => FriendRequest(
  //   friendRequestId: data["_id"],
  //   fromId: data["from"]["_id"],
  //   toId: currentId,
  //   name: data["from"]["name"],
  //   avatar: data["from"]["avatar"],
  // );
}