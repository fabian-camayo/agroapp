import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'global.Dart' as global;
import 'add.dart';
import 'home.dart';
import 'search.dart';
import 'signin.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
_signOut() async {
  await _firebaseAuth.signOut();
  await googleSignIn.signOut();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[Home(), Add(), Search()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      appBar: AppBar(
        leading: Image.asset('assets/images/logo_agroapp.png'),
        leadingWidth: 540,
        toolbarHeight: 80,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Exit',
            iconSize: 40,
            color: const Color(0xFF84cc16),
            onPressed: () async {
              await _signOut();
              if (_firebaseAuth.currentUser == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
                global.img_url_temp =
                    'https://firebasestorage.googleapis.com/v0/b/agroapp-5a42d.appspot.com/o/upload%20img.png?alt=media&token=efb79419-3deb-43db-972c-44f53d0ccf75';
              }
            },
          ) //IconButton
        ], //<Widget>[]
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          )
        ],
        selectedItemColor: Colors.black45,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF84cc16),
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
