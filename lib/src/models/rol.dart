import 'dart:convert';

Rol rolFromJson(String str) => Rol.fromJson(json.decode(str));

String rolToJson(Rol data) => json.encode(data.toJson());

class Rol {
  late String id;
  late String name;
  String? image;
  late String route;

  Rol({
    String id ='',
    String name='',
    String? image ,
    String route='',
  }):
        id = id,
        name=name,
        image=image,
        route=route;

  factory Rol.fromJson(Map<String?, dynamic> json) => Rol(
    id: json["id"] is int ? json['id'].toString() : json['id'],
    name: json["name"] ?? '',
    image: json["image"],
    route: json["route"]?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "route": route,
  };
}
