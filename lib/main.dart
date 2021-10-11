import 'package:flutter/material.dart';
import 'signin.dart';

/**

import 'home.dart';
import 'add.dart';
import 'search.dart';
import 'account.dart';
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
/**
  static const String home = Home.routeName;
  static const String add = Add.routeName;
  static const String search = Search.routeName;
  static const String account = Account.routeName;
  // This widget is the root of your application.
  **/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agroapp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
/**      routes: {
        home: (context) => Home(),
        add: (context) => Add(),
        search: (context) => Search(),
        account: (context) => Account(),
      },
      **/
      home: SignIn(),
    );
  }
}
