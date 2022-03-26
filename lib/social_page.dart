import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_eaters/home_page.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/auth_service.dart';
import 'package:social_eaters/services/user_service.dart';
import 'package:social_eaters/ui/place_card.dart';

import 'models/user_model.dart';
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
                        ///
                        buildFollowersColumn(),

                        ///
                        buildProfileIconColumn(),

                        ///
                        buildFollowingColumn(),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 72.0, left: 22.0),
                    child: profileAndWelcomeText()),
              ],
            ),
            buildYourQRButton(context),
          ],
        ),
      ),
    );
  }

  Widget profileAndWelcomeText() {
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
              "Profile",
              style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                  color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  GestureDetector buildYourQRButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        buildUsersQrDialog(context);
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
    );
  }

  GestureDetector buildFollowingColumn() {
    return GestureDetector(
      onTap: () {
        //TODO BUILD USER LIST
        buildUserList(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Following",
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 15.0,
          ),
          FutureBuilder(
            future: UserService.instance.getFollowingUserCount(
                AuthenticationService.instance.getUserId()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int followingCount = snapshot.data;
                return Text(followingCount.toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600));
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Column buildProfileIconColumn() {
    return Column(
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
              Icons.person,
              color: Color(0xFFB870D0),
            ),
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        FutureBuilder(
          future: UserService.instance
              .getUserInfoById(AuthenticationService.instance.getUserId()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserModel user = snapshot.data;
              return Text(
                user.name!,
                style: const TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  GestureDetector buildFollowersColumn() {
    return GestureDetector(
      onTap: () {
        //TODO BUILD USER LIST
        buildUserList(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Followers",
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 15.0,
          ),
          FutureBuilder(
            future: UserService.instance.getFollowerUserCount(
                AuthenticationService.instance.getUserId()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int followingCount = snapshot.data;
                return Text(followingCount.toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600));
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

buildUsersQrDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Your QR'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Users can follow you by scanning this QR code.'),
              SizedBox(
                height: 100,
                width: 100,
                child: QrImage(
                  data: AuthenticationService.instance.getUserId(),
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
}

//TODO USER LIST UI
buildUserList(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Your QR'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Users can follow you by scanning this QR code.'),
              SizedBox(
                height: 100,
                width: 100,
                child: QrImage(
                  data: AuthenticationService.instance.getUserId(),
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
}
