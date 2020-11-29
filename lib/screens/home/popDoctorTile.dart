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
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: widget.doctor.pictureLink,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
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
                  SizedBox(height: 10.0),
                  Text(widget.doctor.appointmentPrice.toString() + " /= Kes",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton.icon(
                          textColor: Colors.white,
                          color: Colors.green,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorIndividual(
                                      doctorId: widget.doctor.id),
                                ),
                              ),
                          label: Text("View profile",
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: "Poppins"))),
                      SizedBox(width: 10.0),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
