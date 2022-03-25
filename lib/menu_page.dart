import 'package:flutter/material.dart';
import 'package:social_eaters/features/maps/map_view.dart';
import 'package:social_eaters/home_page.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/local_storage.dart';
import 'package:social_eaters/services/preferences_keys.dart';
import 'package:social_eaters/ui/place_card.dart';

import 'features/scan_menu.dart';
import 'ui/wave_clipper.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Place> places = [];

  getVisitedPlaces() {
    List<String> stringData =
        LocalStorage.instance.getStringList(PreferencesKeys.places);
    for (String string in stringData) {
      places.add(Place.fromJson(string));
    }
  }

  @override
  void initState() {
    super.initState();
    getVisitedPlaces();
  }

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
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapViewPage()));
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
                                    Icons.map,
                                    color: Color(0xFFB870D0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7.0,
                              ),
                              const Text("Map View",
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
                Padding(
                    padding: const EdgeInsets.only(top: 72.0, left: 22.0),
                    child: header()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PlaceCard(place: places[index]);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

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
              "Visit history",
              style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                  color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
