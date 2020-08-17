import 'package:flutter/material.dart';
import 'package:oria/models/user.dart';
import 'package:oria/screens/home/home2.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    //Return either home or authenticate widget
  }
}
