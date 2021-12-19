import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:fromvalidation/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-c879c-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product selectedProduct;

  File? newPictureFile;
  String? newNamePicture;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saverOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    if (kDebugMode) {
      print(decodedData);
    }

    //Update the list of products
    products[products.indexWhere((element) => element.id == product.id)] =
        product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(XFile file) {
    selectedProduct.picture = file.path;

    newPictureFile = File(file.path);
    newNamePicture = file.name;
    if (kDebugMode) {
      print(newNamePicture);
    }
    // this.newPictureFile = File.fromUri(Uri(path: this.selectedProduct.picture));
    notifyListeners();
  }

  Future uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return await ref.putFile(file);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
