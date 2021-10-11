import 'package:flutter/material.dart';

import 'add.dart';
import 'home.dart';
import 'search.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[Add(), Home(), Search()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset('assets/images/logo_agroapp.png'),
        leadingWidth: 540,
        toolbarHeight: 80,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Cuenta',
            iconSize: 60,
            color: const Color(0xFF84cc16),
            onPressed: () {},
          ) //IconButton
        ], //<Widget>[]
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
/**   @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildNavHeader(),
          _buildNavItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, MyApp.home)}),
          _buildNavItem(
              icon: Icons.account_circle,
              text: 'Add',
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, MyApp.add)}),
          _buildNavItem(
              icon: Icons.movie,
              text: 'Search',
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, MyApp.search)}),
          _buildNavItem(
              icon: Icons.contact_phone,
              text: 'Account ',
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, MyApp.account)}),
        ],
      ),
    );
  }

  Widget _buildNavHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/logo_google.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Compilación Movil",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _buildNavItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
**/





/**  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset('assets/images/logo_agroapp.png'),
        leadingWidth: 540,
        toolbarHeight: 80,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Cuenta',
            iconSize: 60,
            color: const Color(0xFF84cc16),
            onPressed: () {},
          ) //IconButton
        ], //<Widget>[]
      ),
      body: Center(
        child: Text('You have pressed the button times.'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
        ],
        selectedItemColor: Colors.black45,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF84cc16),
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
      ),
    );
  }
}
**/