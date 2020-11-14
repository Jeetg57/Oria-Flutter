import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:intl/intl.dart';
import 'package:oria/models/user.dart';
import 'package:oria/screens/home/popDoctors.dart';
import 'package:oria/screens/hospitals/hospitalsMap.dart';
import 'package:oria/screens/imageViewer/imageViewer.dart';
import 'package:oria/screens/profile/profile.dart';
import 'package:oria/services/auth.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/loadingWidget.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void _toggle() {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.end);
  }

  StreamSubscription iosSubscription;
  final DatabaseService databaseService = DatabaseService();

  void initState() {
    super.initState();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      final notification = message['notification'];
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(notification['title']),
                  subtitle: Text(
                    notification['body'],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )); // setState(() {
      //   messages.add(
      //       Message(title: notification['title'], body: notification['body']));
      // });
    }, onLaunch: (Map<String, dynamic> message) async {
      await Navigator.pushNamed(context, "/appointments");
    }, onResume: (Map<String, dynamic> message) async {
      await Navigator.pushNamed(context, "/appointments");
    });
    if (Platform.isIOS) {
      iosSubscription =
          _firebaseMessaging.onIosSettingsRegistered.listen((event) {
        databaseService.saveDeviceToken();
      });
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, alert: true, badge: true));
    } else {
      databaseService.saveDeviceToken();
    }
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    final double devWidth = MediaQuery.of(context).size.width;
    // final double devHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return InnerDrawer(
                key: _innerDrawerKey,
                onTapClose: true, // default false
                swipe: true, // default true
                colorTransitionChild: Colors.white, // default Color.black54
                colorTransitionScaffold:
                    Colors.transparent, // default Color.black54

                //When setting the vertical offset, be sure to use only top or bottom
                offset: IDOffset.only(bottom: 0.03, right: 0.0, left: 0.0),
                scale: IDOffset.horizontal(
                    0.8), // set the offset in both directions

                proportionalChildArea: true, // default true
                borderRadius: 40, // default 0
                leftAnimationType:
                    InnerDrawerAnimation.static, // default static
                rightAnimationType: InnerDrawerAnimation.quadratic,
                backgroundDecoration: BoxDecoration(
                    color: Color.fromRGBO(82, 190, 128,
                        1)), // default  Theme.of(context).backgroundColor

                //when a pointer that is in contact with the screen and moves to the right or left
                // onDragUpdate: (double val, InnerDrawerDirection direction) {
                //   // return values between 1 and 0
                //   print(val);
                //   // check if the swipe is to the right or to the left
                //   print(direction == InnerDrawerDirection.start);
                // },
                // innerDrawerCallback: (a) =>
                //     print(a), // return  true (open) or false (close)
                // leftChild: Container(), // required if rightChild is not set
                rightChild: Scaffold(
                  backgroundColor: Color.fromRGBO(82, 190, 128, 1),
                  body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OriaImageView(
                                      url: userData.pictureLink))),
                          child: Hero(
                            tag: "image-view",
                            child: CircleAvatar(
                              backgroundImage: userData.pictureLink != null
                                  ? NetworkImage(userData.pictureLink)
                                  : AssetImage(
                                      "assets/images/person_placeholder.png"),
                              radius: devWidth * 0.1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("My Profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 14.0)),
                                leading:
                                    Icon(Icons.person, color: Colors.white),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile())),
                              ),
                              ListTile(
                                title: Text("Settings",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 14.0)),
                                leading:
                                    Icon(Icons.settings, color: Colors.white),
                              ),
                              ListTile(
                                title: Text("Sign Out",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    )),
                                trailing: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                ),
                                onTap: () async {
                                  await _auth.signOut();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), // required if leftChild is not set

                //  A Scaffold is generally used but you are free to use other widgets
                // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
                scaffold: Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: Color.fromRGBO(247, 249, 249, 1),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      elevation: 0.0,
                      title: Text(
                        "Oria",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24.0,
                            // letterSpacing: 1.5,
                            fontFamily: "Poppins"),
                      ),
                      backgroundColor: Color.fromRGBO(247, 249, 249, 1),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              onPressed: () => _toggle()),
                        ),
                        // IconButton(
                        //     icon: Icon(
                        //       Icons.settings,
                        //       color: Colors.black,
                        //     ),
                        //     onPressed: null)
                      ],
                    ),
                    body: SingleChildScrollView(
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat.MMMMEEEEd()
                                        .format(DateTime.now()),
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
                                    style: TextStyle(
                                        fontSize: 18.0, fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Card(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ListTile(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HospitalsMap()),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 10.0),
                                                  title: Text(
                                                    "Hospitals",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                  Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ListTile(
                                          onTap: () => Navigator.pushNamed(
                                              context, "/appointments"),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 10.0),
                                          title: Text(
                                            "Upcoming Appointments",
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
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text("Popular Doctors in your area",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins")),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: PopularDoctors()),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton.icon(
                                    onPressed: () => Navigator.pushNamed(
                                        context, "/doctors"),
                                    icon: Icon(Icons.forward),
                                    label: Text("View All")),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            )
                          ],
                        ),
                      ),
                    )));
          } else {
            return LoadingWidget();
          }
        });
  }
}
