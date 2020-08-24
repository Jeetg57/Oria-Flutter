import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/doctors/individual_info/doctor.dart';

class DoctorTile extends StatelessWidget {
  final DoctorData doctor;
  DoctorTile({this.doctor});
  @override
  Widget build(BuildContext context) {
    var f = new NumberFormat("#,##0", "en_US");
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
        margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorIndividual(doctorId: doctor.id),
            ),
          ),
          leading: new ClipRRect(
            borderRadius: new BorderRadius.circular(30.0),
            child: FadeInImage.assetNetwork(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 10),
              fadeInCurve: Curves.easeInQuad,
              placeholder: 'assets/images/person_placeholder.png',
              image:
                  'https://firebasestorage.googleapis.com/v0/b/oria-68e38.appspot.com/o/person1.jpg?alt=media&token=5362a60a-ff36-45c2-a31f-68b70bc13691',
            ),
          ),
          title: Text(doctor.name,
              style: TextStyle(fontFamily: "Poppins", fontSize: 18.0)),
          subtitle:
              Text(doctor.specialty, style: TextStyle(fontFamily: "Poppins")),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.location_on, size: 15.0, color: Colors.green),
              Text(doctor.city,
                  style: TextStyle(
                      fontFamily: "Poppins", color: Colors.grey[800])),
            ],
          ),
        ),
      ),
    );
  }
}
