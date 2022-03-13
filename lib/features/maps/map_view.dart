import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  final Location _location = Location();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
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
}
