import 'dart:convert';

import 'package:rent_finder/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  late String id;
  late String name;
  late String lastname;
  late String email;
  late String phone;
  late String password;
  String? image;
  late String seccion_token;
  late List<Rol> roles;
  List<User> toList = [];

  User({
    String id= '',
    String name='',
    String lastname='',
    String email='',
    String phone='',
    String password='',
    String? image,
    String seccion_token='',
    List<Rol> roles = const [],
  }):
        id= id,
        name=name,
        lastname=lastname,
        email=email,
        phone=phone,
        password=password,
        image=image,
        seccion_token = seccion_token,
        roles=roles;

  factory User.fromJson(Map<String?, dynamic> json) => User(
    id: json["id"] is int ? json['id'].toString() : json['id'],
    name: json["name"]  ?? '',
    lastname: json["lastname"]  ?? '',
    email: json["email"]  ?? '',
    phone: json["phone"]  ?? '',
    password: json["password"]  ?? '',
    image: json["image"] ,
    seccion_token: json["seccion_token"] == null ? '' : json["seccion_token"],
    roles: json['roles'] == null ? [] : List<Rol>.from(json['roles'].map((model) => Rol.fromJson(model))) ?? [],
  );

  User.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;
    jsonList.forEach((item) {
      User user = User.fromJson(item);
      toList.add(user);
    });

  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "image": image ,
    "seccion_token": seccion_token,
    "roles" : roles,
  };
}
