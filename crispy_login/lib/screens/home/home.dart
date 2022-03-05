import 'package:crispy_login/models/brew.dart';
import 'package:crispy_login/screens/home/settings_form.dart';
import 'package:crispy_login/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:crispy_login/services/database.dart';
import 'package:provider/provider.dart';
import 'package:crispy_login/screens/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: const SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions:  <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
              style: TextButton.styleFrom(primary: Colors.black)
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: const Icon(Icons.settings),
              label: const Text('settings'),
              style: TextButton.styleFrom(primary: Colors.black)
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            ),
          ),
          child: const BrewList()
        ),
      ),
    );
  }

}