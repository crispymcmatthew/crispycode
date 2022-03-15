import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(
              'lib/assets/images/logo_recipe_app.png',
              fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}