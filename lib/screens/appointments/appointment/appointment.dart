import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oria/shared/loadingWidget.dart';

class AppointmentIndividual extends StatefulWidget {
  final String appointmentId;
  AppointmentIndividual({Key key, @required this.appointmentId})
      : super(key: key);
  @override
  _AppointmentIndividualState createState() => _AppointmentIndividualState();
}

class _AppointmentIndividualState extends State<AppointmentIndividual> {
  bool loading = false;
  var appointment;
  var user;
  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  getSchedule() async {
    setState(() {
      loading = true;
    });
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("appointments")
          .doc(widget.appointmentId)
          .get();
      setState(() {
        appointment = doc.data();
      });
      DocumentSnapshot docUser = await FirebaseFirestore.instance
          .collection("doctors")
          .doc(appointment["doctorId"])
          .get();
      setState(() {
        loading = false;
        user = docUser.data();
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Color.fromRGBO(247, 249, 249, 1),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0.0,
              title: Text(
                "Appointment Status",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24.0,
                    // letterSpacing: 1.5,
                    fontFamily: "Poppins"),
              ),
              backgroundColor: Color.fromRGBO(247, 249, 249, 1),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Doctor Info",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromRGBO(28, 40, 51, 1),
                          fontSize: 20.0),
                    ),
                    subtitle: Text(
                      "Some info about the patient",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(212, 230, 241, 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          user["name"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          user["email"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Birthdate",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(
                                  user["birthdate"].toDate().toString()))
                              .toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Specialty",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          user["specialty"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Appointment Price",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          user["appointmentPrice"].toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.book,
                      size: 40,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Appointment Details",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromRGBO(28, 40, 51, 1),
                          fontSize: 20.0),
                    ),
                    subtitle: Text(
                      "Information about your appointment",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(212, 230, 241, 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          DateFormat('EEEE MMMM d - HH:m a')
                              .format(DateTime.parse(
                                  appointment["time"].toDate().toString()))
                              .toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Approval",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          appointment["approval"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton.extended(
                      onPressed: null, label: Text("View Notes"))
                ],
              ),
            ),
          );
  }
}
