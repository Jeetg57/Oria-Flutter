import 'package:flutter/material.dart';

class Welcome1Widget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.green,
        title: Text("Oria"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 303,

              child: Image.asset(
                "assets/images/undraw_medicine_movn-image.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 90),
                child: Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: "",
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                    letterSpacing: 0.4,
                    height: 1.09375,
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 217,
                margin: EdgeInsets.only(bottom: 78),
                child: Text(
                  "Sed ut perspiciatis unde omnis iste natus error sit.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: "",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.175,
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 44),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 17),
                    child: Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "",
                        fontWeight: FontWeight.w400,
                        fontSize: 24,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}