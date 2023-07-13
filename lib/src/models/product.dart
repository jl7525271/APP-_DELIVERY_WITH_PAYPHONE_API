import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  late String id;
  late String name;
  late String description;
  late String image1;
  late String image2;
  late String image3;
  late double price;
  late int id_category;
  late int? quantity;
  List<Product>toList = [];

  Product({
    String id = '',
    String name = '',
    String description = '',
    String image1 = '',
    String image2 = '',
    String image3 = '',
    double price = 0.00,
    int id_category = 0,
    int? quantity,
  })  : id = id,
        name = name,
        description = description,
        image1 = image1,
        image2 = image2,
        image3 = image3,
        price = price,
        id_category = id_category,
        quantity = quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] is int ? json["id"].toString() : json["id"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    price: json["price"] is String ? double.parse(json["price"]): isInteger(json["price"]) ? json["price"].toDouble() : json["price"],
    id_category: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
    quantity: json["quantity"] is String ? int.parse(json["quantity"]) : json["quantity"],
  );

  Product.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null ) return;
    jsonList.forEach((item) {
      Product product = Product.fromJson(item);
      toList.add(product);
    });
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "price": price,
    "id_category": id_category,
    "quantity": quantity,
  };

  static bool isInteger (num value ) => value is int || value == value.roundToDouble();

}
