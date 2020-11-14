import 'package:flutter/material.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/home/popDoctorTile.dart';
import 'package:provider/provider.dart';

class PopDoctorsList extends StatefulWidget {
  @override
  _PopDoctorsListState createState() => _PopDoctorsListState();
}

class _PopDoctorsListState extends State<PopDoctorsList> {
  @override
  Widget build(BuildContext context) {
    final doctors = Provider.of<List<DoctorData>>(context) ?? [];
    return ListView.builder(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return PopDoctorTile(doctor: doctors[index]);
        },
        itemCount: doctors.length);
  }
}
