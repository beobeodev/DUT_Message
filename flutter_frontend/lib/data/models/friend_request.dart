import 'package:flutter/cupertino.dart';

class FriendRequest {
  String friendRequestId;
  String fromId;
  String toId;
  String name;
  String avatar;

  FriendRequest({@required this.friendRequestId, @required this.fromId, @required this.toId, @required this.name, @required this.avatar});
}