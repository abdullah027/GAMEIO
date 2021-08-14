import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map_page.dart';

User loggedInUser;
final _firestore = FirebaseFirestore.instance;
String secondEmail;
String receiverName;


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageBody;
  @override
  void initState() {
    super.initState();
    getProfileData();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

      }
    } catch(e){
      print(e);
    }
  }
  getProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      secondEmail = pref.getString("email");
      receiverName = pref.getString("name");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //messagesStream();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPage()));
              }),
        ],
        title: Text(receiverName),
        backgroundColor: Color(0xFF025472),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        messageBody = value;
                      },
                    ),
                  ),
                  IconButton(
                    color: Colors.yellowAccent,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      messageTextController.clear();
                      //print(secondEmail +" this is the receiver" );
                      //messageBody + loggedInUser.email
                      _firestore.collection("messages").add({
                        'body': messageBody,
                        'id':loggedInUser.email + secondEmail,
                        'sender': loggedInUser.email,
                        'receiver': secondEmail,
                        'timestamp':Timestamp.now(),
                        'createdAt':Timestamp.now().seconds,
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').where('id',whereIn: [loggedInUser.email.toString()+ secondEmail, secondEmail + loggedInUser.email]).orderBy("timestamp", descending: true).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purpleAccent,
              ),
            );
          }
          final msgs = snapshot.data.docs;
          List<MsgBubble>  messageBubbles =[];
          for (var msg in msgs){
            final msgtext = msg.data()['body'];
            final msgsender = msg.data()['sender'];
            final currentUser = loggedInUser.email;
            final messageBubble = MsgBubble(
              sender: msgsender,
              body: msgtext,
              fromSelf: currentUser == msgsender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubbles,
            ),
          );
        }
    );
  }
}

class MsgBubble extends StatelessWidget {
  MsgBubble({this.sender, this.body, this.fromSelf});
  final String sender;
  final String body;
  final bool fromSelf;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: fromSelf ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender, style: TextStyle(
            fontSize: 12.0,
            color: Colors.white60
          ),),
          Material(
            borderRadius: fromSelf ? BorderRadius.only(
                topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)): BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)

            ),
            elevation: 6.0,
            color: fromSelf ? Colors.white : Color(0XFF1D1F33) ,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$body',
                style: TextStyle(
                  fontSize: 16.0,
                  color: fromSelf ? Colors.black : Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );



  }
}


