import 'package:flutter/material.dart';
import 'nav.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  // static const String routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: Center(
        child: Text(
          'Search Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
