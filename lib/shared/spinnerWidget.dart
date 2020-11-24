import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(247, 249, 249, 1),
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.black,
          size: 50.0,
        ),
      ),
    );
  }
}
