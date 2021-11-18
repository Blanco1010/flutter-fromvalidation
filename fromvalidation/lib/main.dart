import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/home_screen.dart';
import 'package:fromvalidation/screen/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material APP',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
      },
    );
  }
}
