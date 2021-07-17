import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabaseService {

  final String uid;
  UserDatabaseService({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String name, int age, String gender, String bio) async {
    return await userCollection.doc(uid).set({
      'name' :name,
      'age': age,
      'gender' : gender,
      'bio': bio,
    });
  }

  //Future<String> GetUserName() async {
  //  final result = await userCollection.doc(uid).get();
 //   return result.doc.data()['displayname'];
 //   }
  }
