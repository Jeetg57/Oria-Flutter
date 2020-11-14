import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:intl/intl.dart';

class Status extends StatelessWidget {
  final bool status;
  final DateTime appointment;
  const Status({Key key, this.status, this.appointment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (appointment != null) {
      final dateFormat = new DateFormat("EEEE, MMM d 'at' hh:mma");
      final time = dateFormat.format(appointment);
      return status
          ? Scaffold(
              backgroundColor: Color.fromRGBO(247, 249, 249, 1),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0.0,
                title: Text(
                  "Appointment Status",
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
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 700,
                        height: 300,
                        child: FlareActor(
                          "assets/animations/success_anim.flr",
                          animation: "success_anim",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "Appointment has been requested",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 34.0,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "You have successfully requested for an appointment on $time",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          child: Text("Go Home"),
                          onPressed: () => Navigator.pushNamed(context, "/"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Color.fromRGBO(247, 249, 249, 1),
              appBar: AppBar(
                  leading: FlatButton.icon(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                      label: Text("")),
                  elevation: 0.0,
                  title: Text(
                    "Book Appointment",
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 700,
                        height: 300,
                        child: FlareActor(
                          "assets/animations/error_anim.flr",
                          animation: "Error",
                        ),
                      ),
                    ),
                  ]),
              body: Column(
                children: [
                  Text("Failed"),
                  RaisedButton(
                    child: Text("Go home"),
                    onPressed: () => Navigator.pushNamed(context, "/"),
                  )
                ],
              ),
            );
    } else {
      return (Scaffold(
        body: Text("An error occured"),
      ));
    }
  }
}
