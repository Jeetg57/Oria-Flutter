import "package:flutter/material.dart";
import 'package:oria/screens/home/home.dart';

class EmailVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        children: <Widget>[
          Text("Email is not verified!"),
          Text("Please check your email and verify your account"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Have an account?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.0),
              FlatButton(
                onPressed: () {
                  return Home();
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
