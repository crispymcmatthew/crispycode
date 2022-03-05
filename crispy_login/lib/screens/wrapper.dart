import 'package:crispy_login/models/user.dart';
import 'package:crispy_login/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    //return either Home or Authenticate widget
    if(user == null) {
      return const Authenticate();
    } else {
      return  Home();
    }
  }
}
