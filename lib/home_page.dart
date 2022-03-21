import 'package:flutter/material.dart';
import 'package:social_eaters/features/scan_menu.dart';

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
                ///
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
                /// Create Box below profile
                ///
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 170.0, bottom: 30.0),
                  child: Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: const Center(
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            const Text("Send",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: const Center(
                                child: Icon(
                                  Icons.mobile_screen_share,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            const Text("Top Up",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: const Center(
                                child: Icon(
                                  Icons.attach_money,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            const Text("Pay",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: const Center(
                                child: Icon(
                                  Icons.vertical_align_bottom,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            const Text("Request",
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

                ///
                /// Create profile
                ///
                Padding(
                    padding: const EdgeInsets.only(top: 72.0, left: 22.0),
                    child: profile()),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Transactions",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w800,
                            fontSize: 15.5),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),

                ///
                /// List Transaction dummy
                ///
                _menu(
                    Icons.gamepad, "Buying PS 5", "Monthly Payment", "-\$510"),
                _menu(Icons.satellite, "Photo Course", "Monthly Payment",
                    "-\$50"),
                _menu(Icons.airport_shuttle, "Car Gas Bill", "Monthly Payment",
                    "-\$210"),
                _menu(
                    Icons.code, "Buying Template", "Monthly Payment", "-\$39"),
                _menu(Icons.golf_course, "Golf Course", "Monthly Payment",
                    "-\$90"),
                _menu(Icons.phone, "Buying Quota", "Monthly Payment", "-\$50"),
              ],
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         ElevatedButton(
    //             onPressed: () async {
    //               await Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => const ScanMenu()));
    //             },
    //             child: const Text("Scan Menu")),
    //         Text(
    //           'HOME PAGE',
    //           style: Theme.of(context).textTheme.headline4,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _menu(IconData icon, String title, String time, String value) {
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
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Color(0xFFA665D1)),
                    child: const Center(
                      child: Icon(Icons.menu),
                    ),
                  ),
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
                        time + "asdmasdas",
                        style: const TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.red,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 15.5,
                ),
              )
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
          color: Color.fromARGB(31, 143, 106, 5).withOpacity(0.09),
        ),
        clipper: TriangleClipper(),
      ),
    );
  }

  ///
  /// Create profile widget
  ///
  Widget profile() {
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

///
/// Create wave appbar
///
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///
/// Create triangle clipper
///
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
