class UserModel {
  String id;
  String name;
  String? nickName;
  String? username;
  String avatar;
  String? phone;
  String? email;
  List<String>? friends;

  bool isSelected;

  UserModel({
    required this.id,
    required this.name,
    this.nickName,
    this.username,
    required this.avatar,
    required this.phone,
    this.email = '',
    this.friends,
    this.isSelected = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] as String,
        name: json['name'] as String,
        nickName: json['nick_name'] as String?,
        username: json['username'] as String?,
        avatar: json['avatar'] as String,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        friends: (json['friends'] as List<dynamic>?)
            ?.map((dynamic x) => x.toString())
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'name': name,
        'username': username,
        'avatar': avatar,
        'phone': phone,
        'email': email,
        'friends': friends,
      };

  @override
  String toString() {
    return 'User(id: $id, name: $name, nickName: $nickName, username: $username, avatar: $avatar, phone: $phone, email: $email, friends: $friends)';
  }
}
