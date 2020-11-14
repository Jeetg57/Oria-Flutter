import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:oria/models/user.dart';
import 'package:oria/screens/profile/profilePicture.dart';
import 'package:oria/services/auth.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/constants.dart';
import 'package:oria/shared/loadingWidget.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email;
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            String formattedTime =
                DateFormat.yMMMMEEEEd().format(userData.birthdate);
            return Scaffold(
                backgroundColor: Color.fromRGBO(247, 249, 249, 1),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  elevation: 0.0,
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24.0,
                        // letterSpacing: 1.5,
                        fontFamily: "Poppins"),
                  ),
                  backgroundColor: Color.fromRGBO(247, 249, 249, 1),
                ),
                body: SingleChildScrollView(
                    child: Container(
                        child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/oria-68e38.appspot.com/o/Blue%20Teal%20Movement%20Chiropractor%20Doctor%20Business%20Card.png?alt=media&token=963f58c5-3405-4253-87ee-f6c8493839a3"),
                              fit: BoxFit.cover)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePicture()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: Hero(
                                tag: 'profPic',
                                child: userData.pictureLink != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(userData.pictureLink),
                                        radius: 60.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/person_placeholder.png"),
                                        radius: 60.0,
                                      )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      userData.name,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    Text(
                      userData.email,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Birthdate",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    ),
                    RaisedButton.icon(
                        onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    new MaterialDialog(
                                  borderRadius: 8.0,
                                  enableFullHeight: true,
                                  enableFullWidth: true,
                                  enableCloseButton: true,
                                  closeButtonColor: Colors.white,
                                  headerColor: Colors.green,
                                  title: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  subTitle: Text(
                                    "Please Input your email",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  onCloseButtonClicked: () {
                                    Navigator.pop(context);
                                  },
                                  children: <Widget>[
                                    Text(
                                      "Once you input your email, we will send you a reset link on your email",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      enabled: true,
                                      decoration: registerInputDecoration
                                          .copyWith(hintText: "Email"),
                                      validator: (val) => val.isEmpty
                                          ? "Please fill out this field"
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 16.0),
                                    // TextField(
                                    //   decoration: InputDecoration(hintText: 'Enter Username'),
                                    // ),
                                  ],
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'OK',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                                fontSize: 12.0,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      onPressed: () {
                                        if (email != null) {
                                          var result =
                                              _auth.resetPassword(email);
                                          if (result == null) {
                                            Fluttertoast.showToast(
                                                msg: "An error occured",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "A password reset email has been sent to you!",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please enter an email address",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }

                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            },
                        icon: Icon(Icons.lock),
                        label: Text("Change Password"))
                  ],
                ))));
          } else {
            return LoadingWidget();
          }
        });
  }
}
