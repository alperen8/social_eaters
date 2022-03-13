import 'package:flutter/material.dart';
import 'package:social_eaters/features/maps/map_view.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/local_storage.dart';
import 'package:social_eaters/services/preferences_keys.dart';
import 'package:social_eaters/ui/place_card.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapViewPage()));
              },
              icon: const Icon(Icons.map))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  return PlaceCard(
                    placeName: places[index].name,
                    userComment: places[index].userComment ?? "",
                    dateCreated: DateTime.now(),
                    menuUrl: places[index].menuUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
