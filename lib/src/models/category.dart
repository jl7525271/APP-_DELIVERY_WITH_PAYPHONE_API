import 'dart:convert';

RestaurantCategory restaurantCategoryFromJson(String str) => RestaurantCategory.fromJson(json.decode(str));

String restaurantCategoryToJson(RestaurantCategory data) => json.encode(data.toJson());

class RestaurantCategory {
  late String id;
  late String name;
  late String description;
  List<RestaurantCategory> toList =[];

  RestaurantCategory({
    id = '',
    name = '',
    description = '',
  }):
      id = id,
      name= name,
      description = description;

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) => RestaurantCategory(
    id: json["id"],
    name: json["name"],
    description: json["description"]
  );

  RestaurantCategory.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null ) return;
    jsonList.forEach((item) {
      RestaurantCategory category = RestaurantCategory.fromJson(item);
      toList.add(category);
    });

  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
