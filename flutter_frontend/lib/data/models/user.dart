import 'dart:convert';

class User {
  String id;
  String name;
  String username;
  String avatar;
  String phone;
  List<String> friends;

  User({
    this.id,
    this.name,
    this.username,
    this.avatar,
    this.phone,
    this.friends,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str) as Map<String, dynamic>);

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["user"]["_id"].toString(),
    name: json["user"]["name"].toString(),
    username: json["user"]["username"].toString(),
    avatar: json["user"]["avatar"].toString(),
    phone: json["user"]["phone"].toString(),
    friends: List<String>.from((json["user"]["friends"] as Iterable<dynamic>).map((dynamic x) => x.toString())),
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


}
