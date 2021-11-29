import 'package:flutter/material.dart';
import 'package:fromvalidation/themes/themes.dart';
import 'package:fromvalidation/routes/routes.dart';

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
      routes: appRoutes,
      darkTheme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
      themeMode: ThemeMode.system,
    );
  }
}
