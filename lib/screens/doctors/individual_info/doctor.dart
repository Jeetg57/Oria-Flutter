import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/appointments/appointmentbooking.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/loadingWidget.dart';

class DoctorIndividual extends StatefulWidget {
  final String doctorId;
  DoctorIndividual({Key key, @required this.doctorId}) : super(key: key);
  @override
  _DoctorIndividualState createState() => _DoctorIndividualState();
}

class _DoctorIndividualState extends State<DoctorIndividual> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return StreamBuilder<DoctorData>(
        stream: DatabaseService().doctorData(widget.doctorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DoctorData doctorData = snapshot.data;
            double rating;
            var f = new NumberFormat("#,##0.##", "en_US");
            if (doctorData.numRated == 0 && doctorData.totalRatings == 0) {
              rating = 0;
            } else {
              rating = doctorData.totalRatings / doctorData.numRated;
            }
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.green,
              appBar: AppBar(
                leading: FlatButton.icon(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    label: Text("")),
                elevation: 0.0,
                backgroundColor: Colors.green,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, top: 7.0),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/oria-68e38.appspot.com/o/person1.jpg?alt=media&token=5362a60a-ff36-45c2-a31f-68b70bc13691"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              doctorData.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                  color: Colors.white,
                                  fontFamily: "Poppins"),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 17.0,
                                ),
                                Text(
                                  doctorData.city + ", " + doctorData.location1,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      wordSpacing: 2.0,
                                      letterSpacing: 3.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27.0),
                    child: RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      ),
                      itemCount: 5,
                      itemSize: 17.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 38.0, left: 38.0, top: 15.0, bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              f.format(doctorData.appointmentPrice),
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              "appointment",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 14.0),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          width: 0.2,
                          height: 22,
                        ),
                        Column(
                          children: [
                            Text(
                              doctorData.experience.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "year experience",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 14.0),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          width: 0.2,
                          height: 22,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(33)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff85FFBD),
                                    Color(0xffFFFB7D),
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.centerLeft)),
                          child: Text(
                            "Call",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  doctorData.conditionsTreated.isEmpty
                      ? SizedBox(
                          height: 0.0,
                        )
                      : Container(
                          height: 44.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: doctorData.conditionsTreated.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.0),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  margin: EdgeInsets.only(right: 13.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13.0,
                                        bottom: 5.0,
                                        right: 20.0,
                                        left: 20.0),
                                    child: Text(
                                        doctorData.conditionsTreated[index],
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                );
                              })),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(34)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 33.0, right: 25.0, left: 25.0),
                            child: Text(
                              "Portfolio",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 25.0, left: 25.0),
                            child: Text(
                              doctorData.description,
                              style: TextStyle(
                                  fontSize: 16.0, fontFamily: "Poppins"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 25.0, left: 25.0),
                            child: Text(
                              "Specialty",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, right: 25.0, left: 25.0),
                            child: Text(
                              doctorData.specialty,
                              style: TextStyle(
                                  fontSize: 16.0, fontFamily: "Poppins"),
                            ),
                          ),
                          // SizedBox(
                          //   height: 10.0,
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 25.0, left: 25.0),
                            child: Text(
                              "Study",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, right: 25.0, left: 25.0),
                            child: Text(
                              doctorData.study,
                              style: TextStyle(
                                  fontSize: 16.0, fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppointmentBooking(doctorId: widget.doctorId),
                  ),
                ),
                // onPressed: () => DatabaseService().setAppointment(
                //     uid: user.uid,
                //     doctorId: doctorId,
                //     dateTime: DateTime.now()),
                icon: Icon(Icons.book),
                backgroundColor: Colors.green,
                label: Text(
                  "Book",
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
