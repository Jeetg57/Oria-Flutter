import 'package:flutter/material.dart';
import 'package:oria/models/brew.dart';
import 'package:oria/screens/home/brew_list.dart';
import 'package:oria/screens/home/settings_form.dart';
import 'package:oria/services/auth.dart';
import 'package:oria/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Oria"),
          backgroundColor: Colors.green,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text("Settings"))
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
