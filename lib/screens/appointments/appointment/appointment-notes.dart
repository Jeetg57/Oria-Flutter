import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentNotes extends StatefulWidget {
  final String appointmentId;
  AppointmentNotes({Key key, @required this.appointmentId}) : super(key: key);

  @override
  _AppointmentNotesState createState() => _AppointmentNotesState();
}

class _AppointmentNotesState extends State<AppointmentNotes> {
  var notes;
  bool loading = false;
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
          .collection("notes")
          .doc(widget.appointmentId)
          .get();
      setState(() {
        notes = doc.data();
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Notes",
          style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24.0,
              // letterSpacing: 1.5,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Color.fromRGBO(130, 224, 170, 1),
      ),
      body: notes == null
          ? Container(
              color: Color.fromRGBO(130, 224, 170, 1),
              width: double.infinity,
              height: double.infinity,
              child: Text("This meeting has not yet started"))
          : Container(
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(130, 224, 170, 1),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your meeting time was " +
                        notes["time-elapsed"] +
                        ". Here is what you should know",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
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
                            "Ailment",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Color.fromRGBO(128, 139, 150, 1)),
                          ),
                          Text(
                            notes["ailment"],
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
                            "Notes",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Color.fromRGBO(128, 139, 150, 1)),
                          ),
                          Text(
                            notes["notes"],
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
                            "Prescription",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Color.fromRGBO(128, 139, 150, 1)),
                          ),
                          Text(
                            notes["medications"],
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
                      )),
                ],
              )),
    );
  }
}
