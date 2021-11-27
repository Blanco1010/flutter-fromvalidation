import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/home_screen.dart';
import 'package:fromvalidation/screen/screens.dart';
import 'package:fromvalidation/themes/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material APP',
      theme: themeData,
      initialRoute: 'home',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
      },
      darkTheme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
      themeMode: ThemeMode.system,
    );
  }
}
