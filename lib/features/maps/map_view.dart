import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/services/local_storage.dart';
import 'package:social_eaters/services/preferences_keys.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({Key? key}) : super(key: key);

  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  final Location _location = Location();
  List<Place> places = [];
  List<Marker> markers = [];

  Future<void> onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    LocationData locationData = await _location.getLocation();
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 13),
      ),
    );
  }

  getVisitedPlaces() {
    List<String> stringData =
        LocalStorage.instance.getStringList(PreferencesKeys.places);
    for (String string in stringData) {
      places.add(Place.fromJson(string));
    }
  }

  createMarkers() {
    for (Place place in places) {
      if (place.latitude != null) {
        markers.add(Marker(
          markerId: MarkerId(place.name),
          position: LatLng(place.latitude!, place.longitude!),
          infoWindow: InfoWindow(
              title: place.name,
              snippet: "tap to see  the menu",
              onTap: () {
                _launchURL(context, place.menuUrl);
              }),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
      }
    }
  }

  @override
  void initState() {
    getVisitedPlaces();
    createMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(markers),
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: onMapCreated,
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String menuUrl) async {
    launch(
      menuUrl,
      customTabsOption: CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        extraCustomTabs: const <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
      safariVCOption: SafariViewControllerOption(
        preferredBarTintColor: Theme.of(context).primaryColor,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  }
}
