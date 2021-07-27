import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Services/User_data.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
//import 'package:gameio/Services/User_data.dart';

class FillInfo extends StatefulWidget {
  @override
  _FillInfoState createState() => _FillInfoState();
}

class _FillInfoState extends State<FillInfo> {
  User user = FirebaseAuth.instance.currentUser;
  File _image;
  final picker = ImagePicker();
  String avatarURL;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String dropdownValue = 'Male';
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController discordController = TextEditingController();
  TextEditingController gamingController = TextEditingController();
  DateTime _selectedDate;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text(''),
          ),
        ],
        title: Center(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Gameio',
              style: TextStyle(
                fontFamily: 'JuliusSansOne',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getUserInfo(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              maxRadius: 60,
                              backgroundColor: Colors.black,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: (_image != null)
                                      ? Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.network(
                                          snapshot.data.get('avatarUrl'),
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 0,
                            height: 0,
                            color: Colors.red,
                            padding: EdgeInsets.only(left: 235, top: 80),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_outlined),
                              onPressed: () {
                                setState(() {
                                  getImage();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        //color: Color(0XFF1D1F33),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: fullnameController,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: snapshot.data.get('name'),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        //color: Color(0XFF1D1F33),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: usernameController,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: snapshot.data.get('displayName'),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Flexible(
                            child: Container(
                              child: Text(
                                'Enter Country : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              controller: countryController,
                              cursorColor: Colors.red,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: snapshot.data.get('country'),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              child: Text(
                                'Playing ? : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              controller: gamingController,
                              cursorColor: Colors.red,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText:
                                    snapshot.data.get('currentlyPlaying'),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              child: Text(
                                'Enter Disord Url: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              controller: discordController,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText:
                                    snapshot.data.get('discord_username'),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 150,
                        //color: Color(0XFF1D1F33),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 11,
                          textAlign: TextAlign.left,
                          controller: bioController,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              //borderSide: BorderSide.none,
                            ),
                            hintText: snapshot.data.get('bio'),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Color(0XFF1D1F33),
                            height: 50,
                            width: 89,
                            child: TextButton(
                              child: Text(
                                "Select DOB",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                selectDate(context);
                              },
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 80,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: ageController,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: snapshot.data.get('age').toString(),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.black,
                              value: dropdownValue,
                              elevation: 16,
                              style: TextStyle(color: Colors.white),
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                                'Other',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 80,
                        child: TextButton(
                          onPressed: () {
                            UserDatabaseService(uid: user.uid)
                                .uploadPicture(_image);

                            UserDatabaseService(uid: user.uid).updateUserData(
                                usernameController.text.trim(),
                                fullnameController.text.trim(),
                                int.parse(ageController.text),
                                dropdownValue.trim(),
                                bioController.text.trim(),
                                countryController.text.trim(),
                                gamingController.text.trim(),
                                discordController.text.trim(),
                                checkUrl(avatarURL));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapPage()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFEB1555)),
                          ),
                          child: Center(
                            child: Text("Update",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.greenAccent,
              ),
              dialogBackgroundColor: Colors.black54,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      DateTime today = new DateTime.now();
      _selectedDate = newSelectedDate;
      AgeDuration age;
      age = Age.dateDifference(
          fromDate: newSelectedDate, toDate: today, includeToDate: false);
      int out = age.years;
      ageController
        ..text = "$out"
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: ageController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

Future<DocumentSnapshot> getUserInfo() async {
  var firebaseUser =
      await FirebaseAuth.instance.currentUser; //retrieve current user logged in
  return await FirebaseFirestore.instance
      .collection("Users")
      .doc(firebaseUser.uid)
      .get();
  //get profile record of current user form firebase and return snapshot of document
}

String checkUrl(String Url) {
  User user = FirebaseAuth.instance.currentUser;
  if (Url != null) {
    return "gs://gameio-c7058.appspot.com/user/profile/$user.uid";
  } else {
    return "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
  }
}
