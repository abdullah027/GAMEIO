import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth.dart';

class UserDatabaseService {
  var value;
  final String uid;
  UserDatabaseService({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');

  Future addUserData( String name, int age, String gender, String bio) async {
    return await userCollection.doc(uid).set({
      'name' :name,
      'age': age,
      'gender' : gender,
      'bio': bio,
    }, SetOptions(merge: true));
  }

  Future updateUserData(String username, String name, int age, String gender, String bio) async {
    return await userCollection.doc(uid).set({
      'displayName': username,
      'name' :name,
      'age': age,
      'gender' : gender,
      'bio': bio,
    }, SetOptions(merge: true));

  }


  Future isLoggedIn(String name, int age, String gender, String bio) async {
    return await userCollection.doc(uid).set({
      'isloggedin' :true,
    }, SetOptions(merge: true));
  }

  Future updateUsername(String username) async {
    return await userCollection.doc(uid).set({
      'username' :username,
    }, SetOptions(merge: true));
  }


  Future isLoggedOut(String name, int age, String gender, String bio) async {
    return await userCollection.doc(uid).set({
      'isloggedin' :false,
    }, SetOptions(merge: true));
  }

  Future<String> GetUserName() async {
   final result = await userCollection.doc(uid).get().then(value);
    String name = value.data()['name'];
    print(name);
    return name;
    }
  }

