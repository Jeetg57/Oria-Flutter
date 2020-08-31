import 'package:flutter/material.dart';
import 'package:oria/models/appointments.dart';
import 'package:provider/provider.dart';

import 'appointment_tile.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<List<Appointment>>(context) ?? [];
    // print(doctors.length);
    return ListView.builder(
        itemBuilder: (context, index) {
          return AppointmentTile(appointment: appointments[index]);
        },
        itemCount: appointments.length);
  }
}
