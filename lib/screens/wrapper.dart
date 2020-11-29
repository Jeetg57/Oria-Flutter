import 'package:flutter/material.dart';
import 'package:oria/models/user.dart';
import 'package:oria/screens/home/homeMain.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authenticate/authenticate.dart';
import 'authenticate/onboarding.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool onboard = false;
  checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool("onboarding-completed");
    if (boolValue != null) {
      setState(() {
        onboard = boolValue;
      });
    }
    print(boolValue);
    print(onboard);
    return boolValue;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomeMain();
    }
    //Return either home or authenticate widget
  }
}
