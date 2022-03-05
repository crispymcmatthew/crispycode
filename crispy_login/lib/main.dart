import 'package:crispy_login/models/user.dart';
import 'package:crispy_login/screens/wrapper.dart';
import 'package:crispy_login/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: Users(uid: ''),
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
