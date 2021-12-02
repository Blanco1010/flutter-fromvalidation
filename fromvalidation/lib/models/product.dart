// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.name,
    this.picture,
    required this.price,
    required this.available,
  });

  String name;
  String? picture;
  int price;
  bool available;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        picture: json["picture"],
        price: json["price"],
        available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "picture": picture,
        "price": price,
        "available": available,
      };
}
