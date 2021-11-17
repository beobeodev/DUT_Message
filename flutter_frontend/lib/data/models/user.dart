import 'dart:convert';

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.password,
    this.avatar,
    this.phone,
    this.friends,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str) as Map<String, dynamic>);

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["_id"].toString(),
    firstName: json["firstName"].toString(),
    lastName: json["lastName"].toString(),
    email: json["email"].toString(),
    username: json["username"].toString(),
    password: json["password"].toString(),
    avatar: json["avatar"].toString(),
    phone: json["phone"].toString(),
    friends: List<dynamic>.from((json["friends"] as Iterable<dynamic>).map<dynamic>((dynamic x) => x)),
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "username": username,
    "password": password,
    "avatar": avatar,
    "phone": phone,
    "friends": List<dynamic>.from(friends.map<dynamic>((dynamic x) => x)),
  };

  String id;
  String firstName;
  String lastName;
  String email;
  String username;
  String password;
  String avatar;
  String phone;
  List<dynamic> friends;
}
