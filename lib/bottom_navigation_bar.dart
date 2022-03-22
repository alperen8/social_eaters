import 'package:flutter/material.dart';
import 'package:social_eaters/config/constanst.dart';
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
  int _currentIndex = 1;
  final List<Widget> _children = [
    const MenuPage(),
    const HomePage(),
    const SocialPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppConstants.mainColor,
            selectedItemColor: Colors.black,
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: ("menu"),
                backgroundColor: AppConstants.mainColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ("home page"),
                backgroundColor: AppConstants.mainColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin),
                label: ("social page"),
                backgroundColor: AppConstants.mainColor,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
