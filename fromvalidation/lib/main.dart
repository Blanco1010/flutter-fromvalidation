import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:fromvalidation/services/services.dart';

import 'package:fromvalidation/routes/routes.dart';
import 'package:fromvalidation/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthSerivce()),
        ChangeNotifierProvider(create: (_) => ProductsService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material APP',
      theme: themeData,
      initialRoute: 'check_auth',
      routes: appRoutes,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      darkTheme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
      themeMode: ThemeMode.system,
    );
  }
}
