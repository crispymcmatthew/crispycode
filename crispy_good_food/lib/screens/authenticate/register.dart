import 'package:crispy_good_food/services/auth.dart';
import 'package:crispy_good_food/shared/loading.dart';
import 'package:flutter/material.dart';
import '../home/home.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          height: 700,
          width: 450,
          margin: const EdgeInsets.only(top: 59.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Copperplate Gothic Bold',
                      fontSize: 36.0
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                child:  Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 80.0),
                      TextFormField(
                        style: const TextStyle(
                            fontFamily: 'Copperplate Gothic Bold'
                        ),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        ),
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val){
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                          style: const TextStyle(
                              fontFamily: 'Copperplate Gothic Bold'
                          ),
                          cursorColor: Colors.black,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          ),
                          validator: (val) => val!.length < 6 ? 'Enter a password 6+ char long' : null,
                          onChanged: (val){
                            setState(() => password = val);
                          }
                      ),
                      const SizedBox(height: 30.0),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Copperplate Gothic Bold',
                                      fontSize: 21.0
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.amberAccent[700]),
                                ),
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()){
                                    setState(() => loading = true);
                                    dynamic result = await _auth.registerWithEmailAnsPsw(email, password);
                                    if(result == null){
                                      setState(() {
                                        error = 'please supply a valid email';
                                        loading = false;
                                      });
                                    }
                                  }
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 300.0, right: 20.0, left: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Copperplate Gothic Bold',
                            fontSize: 18.0
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.amberAccent[700],
                              fontFamily: 'Copperplate Gothic Bold',
                              fontSize: 18.0
                          ),
                        ),
                      )
                    ]
                ),
              )
            ],
          ),
        )
    );
  }
}