import 'dart:convert';

import 'package:rent_finder/src/models/product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  late String id;
  late String idClient;
  late String? idDelivery;
  late String idAddress;
  late String status;
  late double lat;
  late double lng;
  late int timestamp;
  List<Product>? products = [];
  List<Order> toList = [];

  Order({
    id ='',
    idClient = '',
    idDelivery,
    idAddress = '',
    status = '',
    lat = 9.998,
    lng = 4.99,
    timestamp = 0,
    List<Product>? products,
  }):
        id = id,
        idClient = idClient,
        idDelivery = idDelivery,
        idAddress = idAddress,
        status = status,
        lat = lat,
        lng = lng ,
        timestamp = timestamp,
        products = products;

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
  );

  Order.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;
    jsonList.forEach((item) {
      Order order = Order.fromJson(item);
      toList.add(order);
      print('respuesta del servidor: ${order}');
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
  };
}
