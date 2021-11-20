import 'package:flutter/material.dart';
import 'package:fromvalidation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            CardContainer(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('Login', style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 30),
                  _LoginForm()
                ],
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Crear una nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
        children: [
          _FormField(isEmail: true),
          _FormField(isEmail: false),
        ],
      )),
    );
  }
}

class _FormField extends StatelessWidget {
  final bool isEmail;

  const _FormField({required this.isEmail});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      cursorColor: Colors.red,
      obscureText: !isEmail,
      keyboardType:
          isEmail ? TextInputType.emailAddress : TextInputType.visiblePassword,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        hintText: isEmail ? 'example@gmail.com' : '',
        labelText: isEmail ? 'Correo electrónico' : 'Contraseña',
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(isEmail ? Icons.email : Icons.password,
            color: Colors.red[400]),
      ),
    );
  }
}
