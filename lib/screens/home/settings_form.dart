import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oria/models/user.dart';
import 'package:oria/services/database.dart';
import 'package:oria/shared/constants.dart';
import 'package:oria/shared/loadingWidget.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your brew settings",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? "Please enter a name" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //Dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    onChanged: (val) => _currentSugars = val,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text("$sugar sugars"),
                        value: sugar,
                      );
                    }).toList(),
                  ),
                  //Slider
                  Slider(
                    activeColor:
                        Colors.green[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.green[_currentStrength ?? userData.strength],
                    min: 100,
                    max: 900,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                    divisions: 8,
                  ),
                  RaisedButton(
                      color: Colors.pink,
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                        }
                      })
                ],
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
