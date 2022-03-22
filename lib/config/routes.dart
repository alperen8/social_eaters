import 'package:flutter/material.dart';
import 'package:social_eaters/bottom_navigation_bar.dart';
import 'package:social_eaters/features/login/login_page.dart';

class Routes {
  static const login = '/login';
  static const home = '/main';
}

var routes = <String, WidgetBuilder>{
  Routes.login: (context) => const LoginPage(),
  Routes.home: (context) => const BottomNavigationBarView(),
};
