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
  late int? id_category;
  late int? quantity;

  Product({
    id = '',
    name= '',
    description ='',
    image1= '',
    image2 = '',
    image3 ='',
    price = 0.00,
    id_category,
    quantity,
  }):
        id =  id,
        name=  name,
        description = description,
        image1= image1,
        image2 =  image2,
        image3 = image3,
        price = price,
        id_category= id_category,
        quantity= quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    price: json["precio"]?.toDouble(),
    id_category: json["id_category"],
    quantity: json["quantity"],
  );

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
}
