import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'firebase_auth.dart';

class UserDatabaseService {
  var value;
  final String uid;
  FirebaseStorage storage = FirebaseStorage.instance;

  UserDatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('Users');


  //function called when new user is created to store name
  Future addUserData(String name, int age, String gender, String bio) async {
    // set default values and name
    return await userCollection.doc(uid).set({
      'displayName': "",
      'country': "",
      'currentlyPlaying': "",
      'name': name,
      'age': age,
      'gender': gender,
      'bio': bio,
      'discord_username': ""
    }, SetOptions(merge: true));
  }

// update profile data of user
  Future updateUserData(String username, String name, int age, String gender,
      String bio, String country, String avatarUrl) async {
    //set particulars of user
    return await userCollection.doc(uid).update({
      'displayName': username,
      'name': name,
      'age': age,
      'gender': gender,
      'bio': bio,
      "country": country,
      //"avatarUrl" : avatarUrl
    }, ); // merge with old record

  }

//set logged in value to true
  Future isLoggedIn() async {
    return await userCollection.doc(uid).set({
      'isloggedin': true,
    }, SetOptions(merge: true));
  }

  Future updateUsername(String username) async {
    return await userCollection.doc(uid).set({
      'username': username,
    }, SetOptions(merge: true));
  }
  Future setavatarUrl(String Url) async {
    return await userCollection.doc(uid).set({
      'avatarUrl': Url,
    }, SetOptions(merge: true));
  }

//set logged in value to false
  Future isLoggedOut() async {
    return await userCollection.doc(uid).set({
      'isloggedin': false,
    }, SetOptions(merge: true));
  }

  Future<String> uploadPicture(File file) async{
    //String avatarURL;
  Reference storageRef = storage.ref().child("user/profile/${uid}.jpeg");
  UploadTask uploadTask = storageRef.putFile(file);
  uploadTask.whenComplete(() async{
    storageRef.getDownloadURL().then((avatarUrl){
      this.setavatarUrl(avatarUrl);
      print(avatarUrl);
    } );

  }).catchError((onError){
    print(onError);
  });

  ;
  }

}

