import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class FillInfo extends StatefulWidget {
  @override
  _FillInfoState createState() => _FillInfoState();
}

class _FillInfoState extends State<FillInfo> {
  File _image;
  final picker = ImagePicker();

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
  DateTime _selectedDate;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(children: [
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: Color(0xFFEB1555),
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
                                  "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 90, top: 80),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt_outlined),
                        onPressed: () {
                          setState(() {
                            getImage();
                          });
                        },
                      ),
                    ),
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Container(
                      color: Color(0XFF1D1F33),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: usernameController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //SizedBox(
              // height: 20,
              //),
              Flexible(
                child: Container(
                  color: Color(0XFF1D1F33),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: usernameController,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Fullname',
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  color: Color(0XFF1D1F33),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 11,
                    textAlign: TextAlign.left,
                    controller: bioController,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                        hoverColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText:
                            'A few words about yourself, your play style and personality...'),
                  ),
                ),
              ),
              //SizedBox(
              //height: 25,
              //),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
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
                  ),
                  Flexible(
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: ageController,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
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
                  ),
                ],
              ),
              //SizedBox(
              // height: 100,
              //),
              Flexible(
                child: Container(
                  height: 80,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
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
              ),
            ],
          ),
        ),
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
        ..text = "$out" + " years"
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: ageController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
