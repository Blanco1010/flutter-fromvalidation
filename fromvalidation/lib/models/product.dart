// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.aviable,
    required this.name,
    this.picture,
    required this.price,
    required this.available,
  });

  bool aviable;
  String name;
  String? picture;
  int price;
  bool available;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        aviable: json["aviable"] == null ? null : json["aviable"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
        available: json["available"] == null ? null : json["available"],
      );

  Map<String, dynamic> toMap() => {
        "aviable": aviable == null ? null : aviable,
        "name": name,
        "picture": picture,
        "price": price,
        "available": available == null ? null : available,
      };
}
