import 'package:crispy_login/models/user.dart';
import 'package:crispy_login/services/database.dart';
import 'package:crispy_login/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crispy_login/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data!;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val)
                ),
                const SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars')
                    );
                  }).toList(),
                  onChanged:(val) => setState(() => _currentSugars = val.toString()),
                ),
                //slider
                Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (val) => setState(() => _currentStrength = val.round())
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink[400])),
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}
