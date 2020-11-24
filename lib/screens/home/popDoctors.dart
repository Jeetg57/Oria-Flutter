import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/home/popDoctorsList.dart';
import 'package:oria/services/database.dart';
import 'package:provider/provider.dart';
import 'package:oria/shared/spinnerWidget.dart';

class PopularDoctors extends StatefulWidget {
  @override
  _PopularDoctorsState createState() => _PopularDoctorsState();
}

class _PopularDoctorsState extends State<PopularDoctors> {
  final geo = Geoflutterfire();
  double lat = 0.0;
  double lng = 0.0;
  GeoFirePoint center;
  Location location = new Location();

  @override
  initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    final pos = await location.getLocation();
    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
      center = geo.point(latitude: lat, longitude: lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (center != null) {
      return StreamProvider<List<DoctorData>>.value(
        value: DatabaseService().doctorDocs(center, 110.0),
        child: PopDoctorsList(),
      );
    } else {
      return Spinner();
    }
  }
}
