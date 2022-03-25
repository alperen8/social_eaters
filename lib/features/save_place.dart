import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/local_storage.dart';
import 'package:social_eaters/services/preferences_keys.dart';
import 'package:social_eaters/services/user_service.dart';

class SaveMenuPage extends StatefulWidget {
  const SaveMenuPage(this.menuLink, {Key? key}) : super(key: key);
  final String menuLink;

  @override
  State<SaveMenuPage> createState() => _SaveMenuPageState();
}

class _SaveMenuPageState extends State<SaveMenuPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
            ),
            TextFormField(
              controller: commentController,
            ),
            Text("tarih: " + date.toString()),
            ElevatedButton(
                onPressed: () async {
                  final Location _location = Location();
                  LocationData locationData = await _location.getLocation();
                  Place place = Place(
                    menuUrl: widget.menuLink,
                    name: nameController.text,
                    userComment: commentController.text,
                    dateVisited: date,
                    latitude: locationData.latitude,
                    longtitude: locationData.longitude,
                  );

                  LocalStorage.instance
                      .addToStringList(PreferencesKeys.places, place.toJson())
                      .then((value) => Navigator.pop(context));
                  UserService.instance.recordPlace(place);
                },
                child: const Text("save place"))
          ],
        ),
      ),
    );
  }
}
