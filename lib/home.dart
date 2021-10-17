import 'package:flutter/material.dart';
import 'nav.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

//  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: const ListTile(
                        title: Text(
                          'The Enchanted Nightingale',
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Me Gusta'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Ver'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
