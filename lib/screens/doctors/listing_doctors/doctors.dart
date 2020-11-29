import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/screens/doctors/listing_doctors/doctorsList.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/constants.dart';
import 'package:oria/shared/loadingWidget.dart';
import 'package:provider/provider.dart';

class Doctors extends StatefulWidget {
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  final geo = Geoflutterfire();
  double _currentSliderValue = 20.0;
  double lat = 0.0;
  double lng = 0.0;
  String search = "";
  GeoFirePoint center;
  Location location = new Location();
  @override
  initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    final pos = await location.getLocation();
    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
      center = geo.point(latitude: lat, longitude: lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (center != null) {
      return StreamProvider<List<DoctorData>>.value(
        value: DatabaseService().doctorDocs(center, _currentSliderValue),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Search Doctor",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            leading: FlatButton.icon(
                padding: EdgeInsets.only(left: 10.0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.black),
                label: Text("")),
            elevation: 0.0,
            backgroundColor: Colors.white,
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
          body: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0, 2),
                          blurRadius: 1.0,
                          spreadRadius: 1.0)
                    ],
                    color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "SEARCH",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                          Icon(
                            Icons.filter_list,
                            size: 12.0,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[100]),
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                      width: double.infinity,
                      child: TextField(
                        // maxLength: 100,
                        minLines: 1,
                        maxLines: 3,
                        decoration: searchInputDecoration.copyWith(
                          hintText: "Search",
                          hintStyle: TextStyle(fontSize: 20.0),
                        ),
                        onChanged: (val) {
                          setState(() {
                            search = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Filter by Distance (km)",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                    ),

                    Slider(
                      value: _currentSliderValue,
                      min: 10,
                      max: 110,
                      divisions: 10,
                      label: "${_currentSliderValue.round().toString()} Km",
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    // Container(
                    //   color: Colors.grey[300],
                    //   width: double.infinity,
                    //   height: 2,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "BRANCHES",
                    //             style: TextStyle(fontSize: 12.0),
                    //           ),
                    //           SizedBox(
                    //             height: 10.0,
                    //           ),
                    //           Text(
                    //             "Radiology",
                    //             style: TextStyle(fontSize: 18.0),
                    //           )
                    //         ],
                    //       ),
                    //       Container(
                    //         color: Colors.grey[300],
                    //         width: 2,
                    //         height: 40.0,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "AVAILABILITY",
                    //             style: TextStyle(fontSize: 12.0),
                    //           ),
                    //           SizedBox(
                    //             height: 10.0,
                    //           ),
                    //           Text(
                    //             "13/07/2020",
                    //             style: TextStyle(fontSize: 18.0),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   color: Colors.grey[300],
                    //   width: double.infinity,
                    //   height: 2,
                    // ),
                    // SizedBox(height: 10.0),
                  ],
                ),
              ),
              Expanded(child: SizedBox(child: DoctorsList())),
            ],
          )),
        ),
      );
    } else {
      return LoadingWidget();
    }
  }
}
