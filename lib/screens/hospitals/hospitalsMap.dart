import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class HospitalsMap extends StatefulWidget {
  @override
  _HospitalsMapState createState() => _HospitalsMapState();
}

class _HospitalsMapState extends State<HospitalsMap> {
  static const String _API_KEY = 'AIzaSyAFBwQIZa75vXwEEPk5Y4Ui8I6A4DcKbMQ';

  List<Marker> markers = <Marker>[];
  @override
  void initState() {
    super.initState();
  }

  void _searchNearby(double latitude, double longitude) async {
    setState(() {
      markers.clear();
    });
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=health&key=$_API_KEY';
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }

  GoogleMapController mapController;
  Location location = Location();
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _animateToUser();
      _setMapStyle();
      _animateToUser();
    });
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString("assets/map_style.json");
    mapController.setMapStyle(style);
  }

  void _animateToUser() async {
    var pos = await location.getLocation();
    _searchNearby(pos.latitude, pos.longitude);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 15.0,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Oria",
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          backgroundColor: Colors.green,
        ),
        body: GoogleMap(
          // _animateToUser(),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0),
            zoom: 11.0,
          ),
          myLocationEnabled: true,
          mapType: MapType.normal,
          trafficEnabled: true,
          compassEnabled: true,
        ));
  }
}
