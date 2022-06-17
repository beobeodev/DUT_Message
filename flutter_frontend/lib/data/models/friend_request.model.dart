class FriendRequestModel {
  String friendRequestId;
  String fromId;
  String toId;
  String name;
  String avatar;

  FriendRequestModel({
    required this.friendRequestId,
    required this.fromId,
    required this.toId,
    required this.name,
    required this.avatar,
  });

  factory FriendRequestModel.fromMap(Map<String, dynamic> data) =>
      FriendRequestModel(
        friendRequestId: data['_id'],
        fromId: data['from']['_id'],
        toId: data['to']['_id'],
        name: data['from']['name'],
        avatar: data['from']['avatar'],
        // avatar: data['from']['avatar'] == null || data['from']['avatar'] == ''
        //     ? 'https://www.zimlive.com/dating/wp-content/themes/gwangi/assets/images/avatars/user-avatar.png'
        //     : data['from']['avatar'],
      );
}
