import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:fromvalidation/services/services.dart';

import 'package:fromvalidation/routes/routes.dart';
import 'package:fromvalidation/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsService())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material APP',
      theme: themeData,
      initialRoute: 'login',
      routes: appRoutes,
      darkTheme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
      themeMode: ThemeMode.system,
    );
  }
}
