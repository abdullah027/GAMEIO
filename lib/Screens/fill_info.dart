import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';

class FillInfo extends StatefulWidget {
  @override
  _FillInfoState createState() => _FillInfoState();
}

class _FillInfoState extends State<FillInfo> {
  String dropdownValue = 'Male';
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Color(0XFF1D1F33),
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left: 10, right: 10),
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
                    SizedBox(
                     height: 20,
                    ),
                    Container(
                      color: Color(0XFF1D1F33),
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 11,
                        textAlign: TextAlign.left,
                        controller: bioController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Description...'),
                      ),
                    ),
                    SizedBox(
                    height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Color(0XFF1D1F33),
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.only(left: 10),
                          height: 40,
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
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: dropdownValue,
                            elevation: 16,
                            style: TextStyle(color: Colors.white),
                            underline: Container(
                              height: 4,
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
                    SizedBox(
                     height: 20,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: double.infinity,
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
                  ],
                ),
              ),
            ],
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
