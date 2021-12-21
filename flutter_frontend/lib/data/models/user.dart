import 'dart:convert';

class User {
  String id;
  String name;
  String nickName;
  String username;
  String avatar;
  String phone;
  List<String> friends;

  User({
    this.id,
    this.name,
    this.nickName,
    this.username,
    this.avatar,
    this.phone,
    this.friends,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str) as Map<String, dynamic>);

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["_id"].toString(),
    name: json["name"].toString(),
    username: json["username"].toString(),
    avatar: json["avatar"].toString() == "" ? "https://www.zimlive.com/dating/wp-content/themes/gwangi/assets/images/avatars/user-avatar.png" : json["avatar"].toString(),
    phone: json["phone"].toString(),
    friends: json["friends"] == null ? <String>[] : List<String>.from((json["friends"] as Iterable<dynamic>).map((dynamic x) => x.toString())),
  );

  factory User.fromMapRoom(Map<String, dynamic> json) => User(
    id: json["member"]["_id"],
    name: json["member"]["name"],
    avatar: json["member"]["avatar"],
    phone: json["member"]["phone"],
    nickName: json["nick_name"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "_id": id,
    "name": name,
    "username": username,
    "avatar": avatar,
    "phone": phone,
    "friends": List<String>.from(friends.map((String x) => x)),
  };

  @override
  String toString() {
    return "$name $avatar $phone";
  }
}


