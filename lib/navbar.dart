import 'package:flutter/material.dart';

//Stateless
class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.index, required this.onTap});

  final void Function(int index) onTap;

  final dynamic index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.filter), label: ('Category')),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          label: ('Interest points'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: ('Favorites'),
        ),
      ],
      currentIndex: index,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        onTap(index);
      },
    );
  }
}

