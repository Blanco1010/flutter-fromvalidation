import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fromvalidation/models/product.dart';

/*
It is required to created a class to handle the data in the form 
 */

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    if (kDebugMode) {
      print(value);
    }
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(product.name);
    // print(product.price);
    // print(product.available);
    // print(product.picture);

    return formKey.currentState?.validate() ?? false;
  }
}
