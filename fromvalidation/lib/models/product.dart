// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product(
      {this.nameToFireBase,
      required this.name,
      this.picture,
      required this.price,
      required this.available,
      this.id});

  String name;
  String? picture;
  double price;
  bool available;
  String? id;
  String? nameToFireBase;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
        available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "picture": picture,
        "price": price,
        "available": available,
      };

  Product copy() => Product(
        name: name,
        price: price,
        available: available,
        picture: picture,
        id: id,
      );
}
