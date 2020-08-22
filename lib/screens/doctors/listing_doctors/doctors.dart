import 'package:flutter/material.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/doctors/listing_doctors/doctorsList.dart';
import 'package:oria/services/database.dart';
import 'package:provider/provider.dart';

class Doctors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DoctorData>>.value(
      value: DatabaseService().doctors,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Oria"),
          backgroundColor: Colors.green,
          elevation: 0.0,
        ),
        body: DoctorsList(),
      ),
    );
  }
}
