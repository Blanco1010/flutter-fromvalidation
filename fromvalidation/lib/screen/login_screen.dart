import 'package:flutter/material.dart';
import 'package:fromvalidation/ui/input_decorations.dart';
import 'package:fromvalidation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                cursorColor: Colors.red,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Correo eletrónico',
                  labelText: 'example@gmail.com',
                  prefixIcon: Icon(Icons.email, color: Colors.red[400]),
                ),
                validator: (vaule) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  if (vaule == '') return null;

                  return regExp.hasMatch(vaule ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  cursorColor: Colors.red,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '**********',
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.password, color: Colors.red[400]),
                  ),
                  validator: (vaule) {
                    if (vaule == '') return null;

                    if (vaule != null && vaule.length >= 6) return null;
                    return 'La contraseña debe ser de 6 caracteres';
                  }),
              SizedBox(height: 30),
              MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.red[500],
                disabledColor: Colors.black,
                elevation: 0,
                child: Container(
                  child: Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  //TODO:
                },
              )
            ],
          )),
    );
  }
}
