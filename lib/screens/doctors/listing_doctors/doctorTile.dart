import 'package:flutter/material.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/doctors/individual_info/doctor.dart';

class DoctorTile extends StatelessWidget {
  final DoctorData doctor;
  DoctorTile({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorIndividual(doctorId: doctor.id),
            ),
          ),
          title: Text(doctor.name),
          subtitle: Text(doctor.speciality),
          trailing: Text(doctor.appointmentPrice.toString()),
        ),
      ),
    );
  }
}
