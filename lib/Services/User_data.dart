import 'package:cloud_firestore/cloud_firestore.dart';

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

}