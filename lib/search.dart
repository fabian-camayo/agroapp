import 'package:flutter/material.dart';
import 'nav.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  // static const String routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 5),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color(0xFF84cc16), // set border color
                      width: 1), // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: 'Buscar Tema',
                    border: InputBorder.none,
                  ),
                )),
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
