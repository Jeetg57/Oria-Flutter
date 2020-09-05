import "package:flutter/material.dart";
import 'package:location/location.dart';
import 'package:oria/models/doctor.dart';
import 'package:provider/provider.dart';

import 'doctorTile.dart';

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    final doctors = Provider.of<List<DoctorData>>(context) ?? [];
    // print(doctors.length);
    return ListView.builder(
        itemBuilder: (context, index) {
          return DoctorTile(doctor: doctors[index]);
        },
        itemCount: doctors.length);
  }
}
