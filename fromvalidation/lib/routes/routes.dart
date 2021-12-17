import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/screens.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  'check_auth': (_) => const CheckAuthScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'home': (_) => const HomeScreen(),
  'product': (_) => const ProductScreen(),
};
