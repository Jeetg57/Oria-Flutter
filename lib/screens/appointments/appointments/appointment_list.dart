import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oria/models/appointments.dart';
import 'package:provider/provider.dart';

import 'appointment_tile.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

final String asset = "assets/images/mask-woman.svg";

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    final appointments = Provider.of<List<Appointment>>(context) ?? [];
    // print(doctors.length);
    if (appointments.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: devWidth * 0.4,
            ),
            Text(
              "Book some appointments and check back here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  wordSpacing: 2.0),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemBuilder: (context, index) {
            return AppointmentTile(appointment: appointments[index]);
          },
          itemCount: appointments.length);
    }
  }
}
