import 'package:flutter/material.dart';
import 'package:fromvalidation/screen/screens.dart';
import 'package:fromvalidation/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthSerivce>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(strokeWidth: 3));
              }

              if (snapshot.data == '') {
                Future.microtask(() {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, ___, ____) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                });
              } else {
                Future.microtask(
                  () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, ___, ____) => const HomeScreen(),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    );
                  },
                );
              }

              return Container();
            }),
      ),
    );
  }
}
