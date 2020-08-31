import 'package:flutter/material.dart';
import 'package:oria/models/appointments.dart';
import 'package:oria/models/user.dart';
import 'package:oria/screens/appointments/appointments/appointment_list.dart';
import 'package:oria/services/database.dart';

import 'package:provider/provider.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);

    return StreamProvider<List<Appointment>>.value(
      value: DatabaseService().appointmentData(user.uid),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(247, 249, 249, 1),
        appBar: AppBar(
          leading: FlatButton.icon(
              padding: EdgeInsets.all(0.0),
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              label: Text("")),
          elevation: 0.0,
          title: Text(
            "My Appointments",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromRGBO(247, 249, 249, 1),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Container(child: SizedBox(child: AppointmentList())),
      ),
    );
  }
}
