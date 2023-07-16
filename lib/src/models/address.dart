import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
 late String id;
 late String idUser;
 late String address;
 late String neighborhood;
 late double lat;
 late double lng;
 List<Address> toList =[];

  Address({
    id ='',
    idUser ='',
    address ='',
    neighborhood ='',
    lat =9.98,
    lng = 9.87,
  }):
        id=id,
        idUser =idUser,
        address = address,
        neighborhood = neighborhood,
        lat =lat,
        lng = lng;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] is int ? json["id"].toString() : json["id"],
    idUser: json["id_user"],
    address: json["address"],
    neighborhood: json["neighborhood"],
    lat:json["lat"] is String ? double.parse(json["lat"]): json["lat"],
    lng:json["lng"] is String ? double.parse(json["lng"]): json["lng"],
  );

 Address.fromJsonList(List<dynamic> jsonList) {
   if (jsonList == null) return;
   jsonList.forEach((item) {
     Address address = Address.fromJson(item);
     toList.add(address);
   });
 }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "address": address,
    "neighborhood": neighborhood,
    "lat": lat,
    "lng": lng,
  };
}
