import 'package:crispy_good_food/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  Users? _userFromUsers(User? user){
    if(user != null){
      return Users(uid: user.uid);
    }
    return null;
  }

  //auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges()
        .map(_userFromUsers);
  }

  //sign in anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user as User;
      return _userFromUsers(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }
  //sign in with email&password
  Future signInWithEmailAnsPsw(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;
      return _userFromUsers(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email&password
  Future registerWithEmailAnsPsw(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;

      return _userFromUsers(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}