import 'package:flutter/material.dart';
import 'package:fromvalidation/models/product.dart';

/*
It is required to created a class to handle the data in the form 
 */

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
