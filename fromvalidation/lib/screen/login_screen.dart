import 'package:flutter/material.dart';
import 'package:fromvalidation/providers/login_form_provider.dart';
import 'package:fromvalidation/ui/input_decorations.dart';
import 'package:fromvalidation/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  ),
                  // _LoginForm()
                ],
              ),
            ),
            SizedBox(height: 50),
            TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.red.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register'),
              child: Text(
                'Crear una nueva cuenta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
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
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
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

                  return regExp.hasMatch(vaule ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                },
                onChanged: (vaule) => loginForm.email = vaule,
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
                  if (vaule != null && vaule.length >= 6) return null;
                  return 'La contraseña debe ser de 6 caracteres';
                },
                onChanged: (vaule) => loginForm.password = vaule,
              ),
              SizedBox(height: 30),
              MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.red[500],
                disabledColor: Colors.black,
                elevation: 0,
                child: Container(
                  width: 150,
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        Future.delayed(Duration(seconds: 2));

                        loginForm.isLoading = false;
                        Navigator.pushReplacementNamed(context, 'home');
                      },
              )
            ],
          )),
    );
  }
}
