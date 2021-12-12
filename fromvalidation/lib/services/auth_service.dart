import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthSerivce extends ChangeNotifier {
  final String _baseUrl = 'https://identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCDI7mXvnXLrykU32IJbjyPIIW7mlakbQQ';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);
  }
}
