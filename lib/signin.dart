import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/gestures.dart';
import 'nav.dart';
import 'signup.dart';
import 'forgotpassword.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class _SignIn extends State<SignIn> {
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
        onChanged: (value) {
          email = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingrese su correo electrónico";
          }
        },
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Correo Electrónico',
          border: InputBorder.none,
        ),
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

  Widget renderSignInButton(BuildContext context) {
    return Container(
        width: 30,
        height: 50,
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        child: ElevatedButton(
          child: Text('Inicia Sesión', style: TextStyle(fontSize: 22)),
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              setState(() {
                isloading = true;
              });
              try {
                await _auth.signInWithEmailAndPassword(
                    email: email, password: password);

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

  Widget renderSignInGoogleButton() {
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
              'Inicia Sesión con Google',
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

  Widget renderForgotPasswordLink(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        child: RichText(
          text: TextSpan(
              text: '¿Olvidaste tu contraseña?',
              style: new TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 19,
                  color: Colors.black54,
                  decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    )),
        ));
  }

  Widget renderSignUpLink(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '¿Eres nuevo en Agroapp? ',
              style: new TextStyle(fontSize: 18, color: Colors.black45),
            ),
            TextSpan(
                text: 'Regístrate',
                style: new TextStyle(
                    fontSize: 19,
                    color: const Color(0xFF84cc16),
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
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
                          renderSignInButton(context),
                          renderSignInGoogleButton(),
                          renderForgotPasswordLink(context),
                          renderSignUpLink(context)
                        ],
                      ),
                    )),
              ));
  }
}
