import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'nav.dart';
import 'signin.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  Widget renderLabelInstructions() {
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: RichText(
          text: TextSpan(
            text:
                'No te preocupes. Te enviaremos un mensaje para ayudarte a restablecer tu contraseña.',
            style: new TextStyle(
              fontFamily: 'Roboto',
              fontSize: 19,
              color: Colors.black54,
            ),
          ),
        ));
  }

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

  Widget renderSendMessageButton(BuildContext context) {
    return Container(
        width: 30,
        height: 50,
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        child: ElevatedButton(
          child: Text('Continuar', style: TextStyle(fontSize: 22)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
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
            renderLabelInstructions(),
            renderEmailInput(),
            renderSendMessageButton(context),
          ],
        ),
      ),
    );
  }
}
