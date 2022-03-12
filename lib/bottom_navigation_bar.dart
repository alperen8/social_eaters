import 'package:flutter/material.dart';
import 'package:social_eaters/home_page.dart';
import 'package:social_eaters/menu_page.dart';
import 'package:social_eaters/social_page.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const MenuPage(),
    const HomePage(),
    const SocialPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: ("menu"),
            backgroundColor: Colors.blue.shade400,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: ("home page"),
            backgroundColor: Colors.blue.shade400,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_pin),
            label: ("Ayarlar"),
            backgroundColor: Colors.blue.shade400,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _children[_currentIndex],
    );
  }
}
