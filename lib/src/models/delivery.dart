import 'dart:convert';
import 'package:rent_finder/src/models/rol.dart';

Delivery deliveryFromJson(String str) => Delivery.fromJson(json.decode(str));

String deliveryToJson(Delivery data) => json.encode(data.toJson());

class Delivery {
  late String? id;
  late String? name;
  late String? lastname;
  String? image;
  List<Delivery>? toList = [];

  Delivery({
    String? id,
    String? name,
    String? lastname,
    String? image,

  }):
        id= id,
        name=name,
        lastname=lastname,
        image=image;


  factory Delivery.fromJson(Map<String?, dynamic> json) => Delivery(
    id: json["id"] is int ? json['id'].toString() : json['id'],
    name: json["name"]  ?? '',
    lastname: json["lastname"]  ?? '',
    image: json["image"]  ?? '',
  );

  Delivery.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;
    jsonList.forEach((item) {
      Delivery delivery = Delivery.fromJson(item);
      toList!.add(delivery);
    });

  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "image": image ,
  };
}
