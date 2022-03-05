import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crispy_login/models/brew.dart';
import 'package:crispy_login/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        sugars: (doc.data() as Map<String, dynamic>)['sugars'] ?? '0',
        name: (doc.data() as Map<String, dynamic>)['name'] ?? '',
        strength: (doc.data() as Map<String, dynamic>)['strength'] ?? 0
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: (snapshot.data() as Map<String, dynamic>)['name'],
      sugars: (snapshot.data() as Map<String, dynamic>)['sugars'],
      strength: (snapshot.data() as Map<String, dynamic>)['strength'],
    );
  }

  //get brews streams
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}