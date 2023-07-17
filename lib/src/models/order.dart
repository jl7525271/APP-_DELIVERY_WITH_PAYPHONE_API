import 'dart:convert';

import 'package:rent_finder/src/models/address.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  late String id;
  late String idClient;
  late String? idDelivery;
  late String idAddress;
  late String status;
  late double? lat;
  late double? lng;
  late int timestamp;
  List<Product> products = [];
  List<Order> toList = [];
  User? client = new User(
    email: '',
    phone: '',
    password: '',
    seccion_token: '',
  );
  Address? address = new Address(
    idUser: '',
  );

  Order({

    id ='',
    idClient = '',
    idDelivery,
    idAddress = '',
    status = '',
    lat = 9.998,
    lng = 4.99,
    timestamp = 0,
    List<Product> products = const [],
    User? client,
    Address? address,
  }):
        id = id,
        idClient = idClient,
        idDelivery = idDelivery,
        idAddress = idAddress,
        status = status,
        lat = lat,
        lng = lng ,
        timestamp = timestamp,
        products = products,
        client= client,
        address= address;


  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] is int ? json["id"].toString() : json["id"],
    idClient: json["id_client"],
    idDelivery: json["id_delivery"],
    idAddress: json["id_address"],
    status: json["status"],
    lat: json["lat"]  is String ? double.parse(json["lat"]): json["lat"],
    lng: json["lng"]  is String ? double.parse(json["lng"]): json["lng"],
    timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]) : json["timestamp"],
    products:json["products"] != null ? List<Product>.from(json["products"].map((model) => Product.fromJson(model))) ?? [] : [],
    client: json["client"] is String ? userFromJson(json["client"]) : User.fromJson(json["client"] ?? {}),
    address: json["address"] is String ? addressFromJson(json["address"]) : Address.fromJson(json["address"] ?? {}),
  );

  Order.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;
    jsonList.forEach((item) {
      Order order = Order.fromJson(item);
      toList.add(order);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "id_delivery": idDelivery,
    "id_address": idAddress,
    "status": status,
    "lat": lat,
    "lng": lng,
    "timestamp": timestamp,
    "products" : products,
    "client": client,
    "address": address,
  };
}
