import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatefulWidget {
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {

  void _launchURL(command) async => await canLaunch(command)
      ? await launch(command)
      : throw 'Could not launch $command';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 200),
            alignment: Alignment.center,
            child: Text(
              'Help Center',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/gamepad.jpg"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 160),
                child: Text(
                  'Gameio Support',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text(
                      "Contact us",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _launchURL('tel:+92 315 293 0197');
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        color: Color(0XFF1D1F33),
                        child: ListTile(
                          leading: Icon(
                            Icons.call,
                          ),
                          title: Text(
                            "+92 315 293 0197",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _launchURL('mailto:fyp.gameio@gmail.com');

                        });
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        color: Color(0XFF1D1F33),
                        child: ListTile(
                          leading: Icon(
                            Icons.mail,
                          ),
                          title: Text(
                            "fyp.gameio@gmail.com",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      color: Color(0XFF1D1F33),
                      child: ListTile(
                        leading: Icon(
                          Icons.question_answer_outlined,
                        ),
                        title: Text(
                          "FAQs",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
