import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oria/models/doctor.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/loadingWidget.dart';

class DoctorIndividual extends StatelessWidget {
  final String doctorId;
  DoctorIndividual({Key key, @required this.doctorId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DoctorData>(
        stream: DatabaseService().doctorData(doctorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DoctorData doctorData = snapshot.data;
            double rating;
            if (doctorData.numRated == 0 && doctorData.totalRatings == 0) {
              rating = 0;
            } else {
              rating = doctorData.totalRatings / doctorData.numRated;
            }
            return Scaffold(
              appBar: AppBar(
                title: Text("Oria"),
                backgroundColor: Colors.green,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/oria-68e38.appspot.com/o/person1.jpg?alt=media&token=5362a60a-ff36-45c2-a31f-68b70bc13691'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Dr, ${doctorData.name}",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                        Text(
                          doctorData.description,
                          style:
                              TextStyle(fontSize: 20.0, fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                            "${doctorData.experience.toString()} Years Experience"),
                        // Text(doctorData.location.latitude.toString()),
                        SizedBox(height: 20.0),
                        Text(
                            "Charges ${doctorData.appointmentPrice.toString()} per appointment"),
                        SizedBox(height: 20.0),
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          onPressed: () => print("Pressed"),
                          child: Text("Book Appointment"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
