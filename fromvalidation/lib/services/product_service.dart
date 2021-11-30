import 'package:flutter/material.dart';
import 'package:fromvalidation/models/models.dart';

class ProductsService extends ChangeNotifier {
  final _baseUrl = 'https://flutter-varios-c879c-default-rtdb.firebaseio.com';

  final List<Product> products = [];
}
