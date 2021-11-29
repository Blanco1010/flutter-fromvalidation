import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/screens.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginScreen(),
  'home': (_) => HomeScreen(),
  'product': (_) => ProductScreen(),
};
