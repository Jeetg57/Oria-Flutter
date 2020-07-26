import 'package:flutter/material.dart';
import 'package:oria/services/auth.dart';
import 'package:oria/shared/constants.dart';
import 'package:oria/shared/loadingWidget.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 0.0,
              title: Text("Sign up to Oria"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign In"))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/images/splash2.png"),
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          validator: (val) {
                            return val.isEmpty ? 'Enter an email' : null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) => val.length < 6
                              ? 'Password should be at least 6 characters'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _authService
                                  .registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = "Please supply a valid email";
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.green,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    )),
              ),
            ),
          );
  }
}
