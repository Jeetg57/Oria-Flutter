import 'package:flutter/material.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/doctors/individual_info/doctor.dart';

class PopDoctorTile extends StatefulWidget {
  final DoctorData doctor;
  PopDoctorTile({this.doctor});
  @override
  _PopDoctorTileState createState() => _PopDoctorTileState();
}

class _PopDoctorTileState extends State<PopDoctorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: widget.doctor.id,
                child: widget.doctor.pictureLink != null
                    ? Image.network(
                        widget.doctor.pictureLink,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.8,
                      )
                    : Image.asset(
                        "assets/images/person_placeholder.png",
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.doctor.name,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins")),
                  Text(widget.doctor.specialty,
                      style: TextStyle(fontSize: 17.0, fontFamily: "Poppins")),
                  Text(widget.doctor.appointmentPrice.toString() + "/= Kes",
                      style: TextStyle(fontSize: 15.0, fontFamily: "Poppins")),
                  RaisedButton.icon(
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DoctorIndividual(doctorId: widget.doctor.id),
                            ),
                          ),
                      label: Text("View profile"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
