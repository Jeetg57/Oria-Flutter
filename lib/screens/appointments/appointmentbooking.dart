import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/datepicker.dart';
import 'package:oria/shared/loadingWidget.dart';
import 'package:provider/provider.dart';
import 'package:oria/models/user.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentBooking extends StatefulWidget {
  final String doctorId;
  AppointmentBooking({Key key, @required this.doctorId}) : super(key: key);
  @override
  _AppointmentBookingState createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime _date = DateTime.now();
  DateFormat formattedDate = new DateFormat('MMMMEEEEd');
  bool loading = false;
  bool showConfirmed = false;
  var _calendarController;
  _showCupertinoDialog({String title, String content, String buttonText}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
              title: new Text(title),
              content: new Text(content),
              insetAnimationCurve: Curves.easeInOutSine,
              actions: <Widget>[
                FlatButton(
                  child: Text(buttonText),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _showMaterialDialog({String title, String content, String buttonText}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text(title),
              content: new Text(content),
              titleTextStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
              contentTextStyle:
                  TextStyle(fontFamily: "Poppins", color: Colors.black),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    buttonText,
                    style:
                        TextStyle(fontFamily: "Poppins", color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    return loading
        ? LoadingWidget()
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
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35.0, vertical: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        SvgPicture.asset(
                          "assets/images/mask-man.svg",
                          height: 100.0,
                        ),
                        Text(
                          "Select a date for your appointment",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                blurRadius: 1.0,
                                spreadRadius: 1.0),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TableCalendar(
                        calendarController: _calendarController,
                        initialSelectedDay: DateTime.now(),
                        onDaySelected: (day, events) {
                          setState(() {
                            _date = day;
                          });
                        },
                        startDay: DateTime.now(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            loading = true;
                            var result = DatabaseService().setAppointment(
                                doctorId: widget.doctorId,
                                uid: user.uid,
                                dateTime: _date);
                            if (result == null) {
                              setState(() {
                                loading = false;
                              });
                              _showMaterialDialog(
                                  title: "An Error Occured",
                                  content: "Please try again",
                                  buttonText: "Close");
                            } else {
                              setState(() {
                                loading = false;
                              });
                              _showMaterialDialog(
                                  title: "Appointment pending approval",
                                  content:
                                      "You have requested this doctor for an appointment on: ${formattedDate.format(_date)}",
                                  buttonText: "Close");
                            }
                          },
                          child: Text("Book Appointment"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
