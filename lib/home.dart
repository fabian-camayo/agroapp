import 'package:flutter/material.dart';
import 'nav.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

//  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: Center(
        child: Text(
          'Home Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
