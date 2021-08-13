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
      'avatarUrl': "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
      'name': name??"name",
      'age': age??0,
      'gender': gender??"other",
      'bio': bio??"Tell us something about yourself",
      "currentlyPlaying": "None",
      "discord_username": "Undefined",
    }, SetOptions(merge: true));
  }

// update profile data of user
  Future updateUserData(String userName, String name, int age, String gender,
      String bio, String country, String currentlyPlaying, String discordUsername, String avatarUrl) async {
    //set particulars of user
    return await userCollection.doc(uid).update({
      'userName': userName??"undefined",
      'name': name??"name",
      'age': age??0,
      'gender': gender??"other",
      'bio': bio??"Tell us something about yourself",
      "country": country??"undefined",
      "currentlyPlaying": currentlyPlaying??"None",
      "discord_username": discordUsername??"Undefined",
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

  Future setEmail(String email) async {
    return await userCollection.doc(uid).set({
      'email': email,
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

