import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:oria/screens/appointments/appointment_status.dart';
import 'package:oria/services/AppointmentService/UserAppointments.dart';
import 'package:oria/services/database.dart';
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
  String time;
  static const _DAYS = 31;
  var doctorSchedule;
  List<String> sched;
  DateTime _date = DateTime.now();
  DateFormat formattedDate = new DateFormat('MMMMEEEEd');
  DateFormat formattedDay = new DateFormat('EEEEE');
  bool buttonEnabled = false;
  bool loading = false;
  bool showConfirmed = false;

  var _calendarController;
  // _showCupertinoDialog({String title, String content, String buttonText}) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => new CupertinoAlertDialog(
  //             title: new Text(title),
  //             content: new Text(content),
  //             insetAnimationCurve: Curves.easeInOutSine,
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text(buttonText),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               )
  //             ],
  //           ));
  // }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    getSchedule();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  getSchedule() async {
    setState(() {
      loading = true;
    });
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("doctor_schedule")
          .doc(widget.doctorId)
          .get();
      setState(() {
        loading = false;
        doctorSchedule = doc.data();
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  // listSchedule(schedule) {
  //   List<String> sched = List.from(schedule["${formattedDay.format(_date)}"]);
  //   return sched;
  // }

  @override
  Widget build(BuildContext context) {
    print(doctorSchedule);
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
            body: doctorSchedule == null
                ? Container(
                    child: Text("This doctor is unavailable"),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 0.0),
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
                              endDay: DateTime.now().add(Duration(days: _DAYS)),
                              weekendDays: [DateTime.sunday],
                              calendarStyle: CalendarStyle(
                                  todayColor: Colors.green[200],
                                  selectedColor: Colors.green,
                                  weekdayStyle:
                                      TextStyle(fontFamily: "Poppins"),
                                  weekendStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.redAccent),
                                  selectedStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Poppins")),
                              headerStyle: HeaderStyle(
                                  titleTextStyle:
                                      TextStyle(fontFamily: "Poppins"),
                                  centerHeaderTitle: true),
                              availableGestures:
                                  AvailableGestures.horizontalSwipe,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (day, events) {
                                print(day);
                                setState(() {
                                  time = null;
                                  _date = day;
                                });
                              },
                              startDay: DateTime.now(),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          doctorSchedule["${formattedDay.format(_date)}"] ==
                                  null
                              ? Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Doctor is unavailable on this day. Please pick another day or doctor",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Go back"),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "The doctor is available from ${doctorSchedule[formattedDay.format(_date)]["startHour"].toString()}:${doctorSchedule[formattedDay.format(_date)]["startMin"].toString()} to ${doctorSchedule[formattedDay.format(_date)]["endHour"].toString()}:${doctorSchedule[formattedDay.format(_date)]["endMin"].toString()}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            loading = true;
                                            var appointment = new DateTime(
                                              _date.year,
                                              _date.month,
                                              _date.day,
                                              doctorSchedule[formattedDay
                                                  .format(_date)]["startHour"],
                                              doctorSchedule[formattedDay
                                                  .format(_date)]["startMin"],
                                              // time.split(" - ").
                                            );
                                            // print(appointment);
                                            bool isFree =
                                                await UserAppointments()
                                                    .userAppointmentData(
                                                        user.uid, appointment);
                                            if (isFree) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        new MaterialDialog(
                                                  borderRadius: 8.0,
                                                  enableFullHeight: true,
                                                  enableFullWidth: true,
                                                  enableCloseButton: true,
                                                  closeButtonColor:
                                                      Colors.white,
                                                  headerColor: Colors.green,
                                                  title: Text(
                                                    "Appointment Confirmation",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  subTitle: Text(
                                                    "",
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  onCloseButtonClicked: () {
                                                    Navigator.pop(context);
                                                  },
                                                  children: <Widget>[
                                                    Text(
                                                      "Confirm your appointment with this doctor",
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Text(
                                                      "By clicking 'OK', you will book an appointment with this doctor on: ${formattedDate.format(appointment)}",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 16.0),
                                                    // TextField(
                                                    //   decoration: InputDecoration(hintText: 'Enter Username'),
                                                    // ),
                                                  ],
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        'CANCEL',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 12.0,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        'OK',
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          loading = true;
                                                        });
                                                        var result = DatabaseService()
                                                            .setAppointment(
                                                                doctorId: widget
                                                                    .doctorId,
                                                                uid: user.uid,
                                                                dateTime:
                                                                    appointment);
                                                        if (result == null) {
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Status(
                                                                      status:
                                                                          false,
                                                                      appointment:
                                                                          null)));
                                                        } else {
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Status(
                                                                            status:
                                                                                true,
                                                                            appointment:
                                                                                appointment,
                                                                          )));
                                                        } // Navigator.pop(context, DialogDemoAction.agree.toString());
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        new MaterialDialog(
                                                  borderRadius: 8.0,
                                                  enableFullHeight: true,
                                                  enableFullWidth: true,
                                                  enableCloseButton: true,
                                                  closeButtonColor:
                                                      Colors.white,
                                                  headerColor: Colors.red,
                                                  title: Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                  subTitle: Text(
                                                    "Appointment Rejection",
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  onCloseButtonClicked: () {
                                                    Navigator.pop(context);
                                                  },
                                                  children: <Widget>[
                                                    Text(
                                                      "You have already have a requested appointment at this time either with this doctor or another.",
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Text(
                                                      "Please check your appointment schedule.",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 16.0),
                                                    // TextField(
                                                    //   decoration: InputDecoration(hintText: 'Enter Username'),
                                                    // ),
                                                  ],
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        'OK',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                fontSize: 12.0,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 18.0,
                                                right: 18.0,
                                                top: 8.0,
                                                bottom: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(33)),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff85FFBD),
                                                      Color(0xffFFFB7D),
                                                    ],
                                                    begin:
                                                        Alignment.bottomRight,
                                                    end: Alignment.centerLeft)),
                                            child: Text(
                                              "Book",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
          );
  }
}

class DialogDemoAction {}
