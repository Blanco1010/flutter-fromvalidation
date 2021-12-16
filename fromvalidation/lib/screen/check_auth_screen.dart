import 'package:flutter/material.dart';
import 'package:fromvalidation/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthSerivce>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {}

              // if(snapshot.data == ''){

              // }
              Future.microtask(() {
                Navigator.of(context).pushReplacementNamed('login');
              });
              return Container();
            }),
      ),
    );
  }
}
