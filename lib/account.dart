import 'package:flutter/material.dart';
import 'nav.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  // static const String routeName = '/account';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      drawer: NavBar(),
      body: Center(
        child: Text(
          'Account Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
