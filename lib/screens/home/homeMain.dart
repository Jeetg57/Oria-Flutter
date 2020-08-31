import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:oria/models/user.dart';
import 'package:oria/screens/hospitals/hospitalsMap.dart';
import 'package:oria/services/auth.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/loadingWidget.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
                key: _scaffoldKey,
                backgroundColor: Color.fromRGBO(247, 249, 249, 1),
                appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer()),
                  elevation: 0.0,
                  title: Text(
                    "Oria",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: "Poppins"),
                  ),
                  backgroundColor: Color.fromRGBO(247, 249, 249, 1),
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        onPressed: null),
                    IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        onPressed: null)
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.green),
                        accountName: Text(userData.name),
                        accountEmail: Text(userData.email),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/oria-68e38.appspot.com/o/userImages%2Fperson1.jpg?alt=media&token=f94732ef-c7c4-4e13-b58a-3346299301f5"),
                          // backgroundColor:
                          //     Theme.of(context).platform == TargetPlatform.iOS
                          //         ? Colors.blue
                          //         : Colors.white,
                          // child: Text(
                          //   userData.name[0],
                          //   style: TextStyle(fontSize: 40.0),
                          // ),
                        ),
                      ),
                      ListTile(
                        title: Text("Messages"),
                        leading: Icon(Icons.message),
                      ),
                      ListTile(
                        title: Text("My Profile"),
                        leading: Icon(Icons.person),
                      ),
                      ListTile(
                        title: Text("Sign Out"),
                        leading: FaIcon(FontAwesomeIcons.signOutAlt),
                        onTap: () async {
                          await _auth.signOut();
                        },
                      ),
                    ],
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(DateTime.now()),
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      Text(
                        "Hi, ${userData.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            fontFamily: "Poppins"),
                      ),
                      Text(
                        "Hope you're well today",
                        style: TextStyle(fontSize: 18.0, fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          // color: Colors.redAccent,
                          child: Container(
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.red, width: 2.0),
                            //     borderRadius: BorderRadius.circular(5.0)),
                            child: ListTile(
                              onTap: () => print("Emergency!"),
                              leading: Icon(
                                Icons.priority_high,
                                color: Colors.red,
                              ),
                              title: Text(
                                "Emergency",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.red,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ListTile(
                                      onTap: () => Navigator.pushNamed(
                                          context, "/doctors"),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 10.0),
                                      title: Text(
                                        "Doctors",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),
                                      leading: Icon(
                                        Icons.person,
                                        size: 40.0,
                                        color: Colors.green,
                                      ),
                                      subtitle: Text(
                                        "Get in touch with a doctor",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ListTile(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HospitalsMap()),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 10.0),
                                      title: Text(
                                        "Hospitals",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),
                                      leading: Icon(
                                        Icons.local_hospital,
                                        size: 40.0,
                                        color: Colors.green,
                                      ),
                                      subtitle: Text(
                                        "Locate the nearest hospital",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ListTile(
                                      onTap: () => Navigator.pushNamed(
                                          context, "/appointments"),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 10.0),
                                      title: Text(
                                        "My Appointments",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),
                                      leading: Icon(
                                        Icons.timer,
                                        size: 40.0,
                                        color: Colors.green,
                                      ),
                                      subtitle: Text(
                                        "View appointments made",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
          } else {
            return LoadingWidget();
          }
        });
  }
}
