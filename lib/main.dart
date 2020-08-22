import 'package:flutter/material.dart';
import 'package:oria/screens/doctors/listing_doctors/doctors.dart';
import 'package:oria/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => Wrapper(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/doctors': (context) => Doctors(),
        },
      ),
    );
  }
}
