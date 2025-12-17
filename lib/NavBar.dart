import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() =>
      _NavBarState();
}

class _NavBarState
    extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Category', style: optionStyle),
    Text('Index 2: Interest Points', style: optionStyle),
    Text('Index 3: Favorites', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home')),
        BottomNavigationBarItem(
          icon: Icon(Icons.filter),
          label: ('Category'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          label: ('Interest points'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: ('Favorites'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}