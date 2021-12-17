import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fromvalidation/services/auth_service.dart';

import 'package:fromvalidation/providers/login_form_provider.dart';

import 'package:fromvalidation/ui/input_decorations.dart';

import 'package:fromvalidation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 200),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Crear cuenta',
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  ),
                  // _LoginForm()
                ],
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.red.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: const Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 50),
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

    return Form(
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
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(vaule ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
              onChanged: (vaule) => loginForm.email = vaule,
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.red[500],
              disabledColor: Colors.black,
              elevation: 0,
              child: SizedBox(
                width: 150,
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Crear una cuenta',
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthSerivce>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        //to show error screen
                        if (kDebugMode) {
                          print(errorMessage);
                        }
                      }

                      loginForm.isLoading = false;
                    },
            )
          ],
        ));
  }
}
