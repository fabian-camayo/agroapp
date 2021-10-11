import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'nav.dart';
import 'signup.dart';
import 'forgotpassword.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
      child: TextField(
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
      child: TextField(
        obscureText: true,
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
            );
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
            onPressed: () {},
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
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()),
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
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      )),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}
