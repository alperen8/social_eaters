import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_eaters/features/scan_menu.dart';
import 'package:social_eaters/models/user_model.dart';
import 'package:social_eaters/services/user_service.dart';

import 'ui/wave_clipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ///
                /// Create wave appbar
                ///
                ClipPath(
                  child: Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(212, 211, 186, 42),
                      Color(0xFFFFBBCF)
                    ])),
                  ),
                  clipper: BottomWaveClipper(),
                ),

                ///
                /// Get triangle widget

                _triangle(
                  20.0,
                  10.0,
                ),
                _triangle(
                  110.0,
                  80.0,
                ),
                _triangle(
                  60.0,
                  190.0,
                ),
                _triangle(
                  40.0,
                  300.0,
                ),
                _triangle(
                  130.0,
                  330.0,
                ),

                ///
                /// Create scan QR button
                ///
                buildScanQR(context),

                Padding(
                    padding: const EdgeInsets.only(top: 72.0, left: 22.0),
                    child: header()),
              ],
            ),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Last visited places",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text("signout")),
              ElevatedButton(
                  onPressed: () async {
                    UserModel? a = await UserService.instance.getUserInfoById(
                        FirebaseAuth.instance.currentUser!.uid);
                    print(a?.name);
                  },
                  child: const Text("asd")),

              ///
              /// List menu dummy
              ///

              // _menu("Place 2", "Comment 1"),
              // _menu("Place 3", "Comment 2"),
              // _menu("Place 4", "Comment 3"),
              // _menu("Place 5", "Comment 4"),
            ])
          ],
        ),
      ),
    );
  }

  Padding buildScanQR(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 170.0, bottom: 30.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScanMenu()));
        },
        child: Container(
          height: 120.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 4.0)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 47.0,
                    width: 47.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: Color(0xFFFAF9FC)),
                    child: const Center(
                      child: Icon(
                        Icons.qr_code,
                        color: Color(0xFFB870D0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  const Text("Scan QR",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu(String title, String comment) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5),
                      ),
                      Text(
                        comment,
                        style: const TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                height: 40.0,
                width: 40.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    color: Color.fromARGB(255, 233, 207, 250)),
                child: const Center(
                  child: Icon(Icons.menu_book),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.black12.withOpacity(0.1),
          )
        ],
      ),
    );
  }

  ///
  /// Triangle for appbar wave
  ///
  Widget _triangle(double top, left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: ClipPath(
        child: Container(
          height: 40.0,
          width: 40.0,
          color: const Color.fromARGB(31, 143, 106, 5).withOpacity(0.09),
        ),
        clipper: TriangleClipper(),
      ),
    );
  }

  ///
  /// Create welcome widget
  ///
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 15.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "User Name here",
              style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                  color: Colors.white),
            ),
            Text(
              "Welcome String",
              style: TextStyle(
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w300,
                  color: Colors.white54),
            )
          ],
        )
      ],
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
