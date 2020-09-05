import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oria/models/appointments.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/appointments/appointment/appointment.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/loadingWidget.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  AppointmentTile({this.appointment});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DoctorData>(
        stream: DatabaseService().doctorData(appointment.doctorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DoctorData doctorData = snapshot.data;
            String formattedTime =
                DateFormat.MMMMEEEEd().format(appointment.time);
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]),
                margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentIndividual(),
                    ),
                  ),
                  title: Text("Appointment with Dr. ${doctorData.name}",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 18.0)),
                  subtitle: Text("Date : $formattedTime",
                      style: TextStyle(fontFamily: "Poppins")),
                  trailing: Text(appointment.approval),
                ),
              ),
            );
          } else {
            return Container(
              child: Text(""),
            );
          }
        });
  }
}
