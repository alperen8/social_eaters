import 'package:flutter/material.dart';
import 'package:social_eaters/services/local_storage.dart';

import 'bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.preferencesInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigationBarView(),
    );
  }
}
