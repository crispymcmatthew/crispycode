import 'package:crispy_good_food/models/users.dart';
import 'package:crispy_good_food/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crispy_good_food/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    //return either Home or Authenticate widget
    if(user == null) {
      return const Authenticate();
    } else {
      return  const Home();
    }
  }
}