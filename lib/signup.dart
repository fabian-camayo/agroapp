import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'nav.dart';
import 'signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  Widget renderEmailInput() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: const Color(0xFF84cc16), // set border color
            width: 1), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Correo Electrónico',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          email = value.toString().trim();
        },
        validator: (value) =>
            (value!.isEmpty) ? 'Por favor ingrese su correo electrónico' : null,
      ),
    );
  }

  Widget renderPasswordInput() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: const Color(0xFF84cc16), // set border color
            width: 1), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
      child: TextFormField(
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor, ingrese su contraseña";
          }
        },
        onChanged: (value) {
          password = value;
        },
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget renderSignUpButton(BuildContext context) {
    return Container(
        width: 30,
        height: 50,
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        child: ElevatedButton(
          child: Text('¡Empezar!', style: TextStyle(fontSize: 22)),
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              setState(() {
                isloading = true;
              });
              try {
                await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blueGrey,
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Regístrado correctamente. Puede iniciar sesión ahora'),
                    ),
                    duration: Duration(seconds: 5),
                  ),
                );
                Navigator.of(context).pop();

                setState(() {
                  isloading = false;
                });
              } on FirebaseAuthException catch (e) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(' ¡Ops! Registro fallido'),
                    content: Text('${e.message}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Ok'),
                      )
                    ],
                  ),
                );
              }
              setState(() {
                isloading = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(primary: const Color(0xFF84cc16)),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color(0xFF84cc16), // set border color
              width: 2.5), // set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // set rounded corner radius
        ));
  }

  Widget renderSignUpGoogleButton() {
    return Container(
        width: 30,
        height: 50,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey, // set border color
              width: 2.5), // set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // set rounded corner radius
        ),
        child: ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                isloading = true;
              });
              try {
                signInWithGoogle();

                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => NavBar(),
                  ),
                );

                setState(() {
                  isloading = false;
                });
              } on FirebaseAuthException catch (e) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("¡Ops! Error de inicio de sesion"),
                    content: Text('${e.message}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Ok'),
                      )
                    ],
                  ),
                );
                print(e);
              }
              setState(() {
                isloading = false;
              });
            },
            icon: ImageIcon(AssetImage('assets/images/logo_google.png')),
            label: Text(
              'Regístrate con Google',
              style: TextStyle(fontSize: 22),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            )));
  }

  Widget renderSignInLink(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 15),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '¿Ya tienes una cuenta? ',
              style: new TextStyle(fontSize: 18, color: Colors.black45),
            ),
            TextSpan(
                text: 'Inicia sesión',
                style: new TextStyle(
                    fontSize: 19,
                    color: const Color(0xFF84cc16),
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      )),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset('assets/images/logo_agroapp.png',
                              width: 540, height: 240),
                        ),
                        renderEmailInput(),
                        renderPasswordInput(),
                        renderSignUpButton(context),
                        renderSignUpGoogleButton(),
                        renderSignInLink(context)
                      ],
                    ),
                  ))),
    );
  }
}
