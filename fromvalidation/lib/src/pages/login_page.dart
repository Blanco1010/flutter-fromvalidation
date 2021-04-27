import 'package:flutter/material.dart';
import 'package:fromvalidation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size; //Obtener los valores.

    final fondoMorado = Container(
      height: size.height * 0.4, //Para la altura
      width: double.infinity, //Rellenar el ancho
      decoration: BoxDecoration(
          //Rellenar el diseño
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circuloColor = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    Widget circulo(double x, double y) {
      return Positioned(
        top: y,
        left: x,
        child: circuloColor,
      );
    }

    final iconoLogin = Container(
      padding: EdgeInsets.only(top: 60.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 125,
          ),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Text(
            'Login',
            style: TextStyle(color: Colors.white, fontSize: 25),
          )
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        circulo(90.0, 30),
        circulo(305, 115),
        circulo(340, 280),
        circulo(0, 190),
        iconoLogin
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 230.0,
            ),
          ),
          Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 30.0), //mover el Container
              padding:
                  EdgeInsets.symmetric(vertical: 50.0), //dentro del decoration
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        //Crear las sombras
                        color: Colors.black26,
                        blurRadius: 1.5,
                        offset: Offset(0, 5),
                        spreadRadius: 3.0),
                  ]),
              child: Column(
                children: <Widget>[
                  Text(
                    'Ingreso',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  _crearEmail(bloc),
                  SizedBox(
                    height: 10.0,
                  ),
                  _crearPassword(bloc),
                  SizedBox(
                    height: 10.0,
                  ),
                  _crearBoton(bloc)
                ],
              )),
          Text('¿Olvido la contraseña?'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo eletrónico',
                errorText: snapshot.error,
                counterText: snapshot.data),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                errorText: snapshot.error,
                labelText: 'Contraseña',
                counterText: snapshot.data),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData
                ? () {
                    _login(bloc, context);
                  }
                : null);
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');

    Navigator.pushReplacementNamed(context, 'home');
  }
}
