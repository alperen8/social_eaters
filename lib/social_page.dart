import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_eaters/home_page.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/auth_service.dart';
import 'package:social_eaters/services/user_service.dart';
import 'package:social_eaters/ui/place_card.dart';

import 'ui/wave_clipper.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                /// Create Box below profile
                ///
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 170.0, bottom: 30.0),
                  child: GestureDetector(
                    onTap: () async {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Your QR'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  const Text(
                                      'Users can follow you by scanning this QR code.'),
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: QrImage(
                                      data: AuthenticationService.instance
                                          .getUserId(),
                                      version: QrVersions.auto,
                                      size: 100.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
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
                                    Icons.qr_code_scanner,
                                    color: Color(0xFFB870D0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7.0,
                              ),
                              const Text("Your QR",
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
                ),
              ],
            ),
            Column(
              children: [
                FutureBuilder(
                  future: UserService.instance.getfollowingUsersMenus(
                      AuthenticationService.instance.getUserId()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Place> places = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: places.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PlaceCard(place: places[index]);
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
