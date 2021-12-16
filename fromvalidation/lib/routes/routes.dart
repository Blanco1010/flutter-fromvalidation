import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/screens.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  'check_auth': (_) => CheckAuthScreen(),
  'login': (_) => LoginScreen(),
  'register': (_) => RegisterScreen(),
  'home': (_) => HomeScreen(),
  'product': (_) => ProductScreen(),
};
