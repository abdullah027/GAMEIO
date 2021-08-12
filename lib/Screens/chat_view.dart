import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'map_page.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String messageBody;
  @override
  void initState() {
    super.initState();

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
//  void getMesages() async {
//    CollectionReference _collectionRef = _firestore.collection('messages');
//    QuerySnapshot querySnapshot = await _collectionRef.get();
//    final messages = querySnapshot.docs.map((doc) => doc.data()).toList();
//    for (var msg in messages) {
//      print(msg['sender']);
//    }
//  }
  void messagesStream() async {
    await for(var snapshot in _firestore.collection('messages').snapshots()){
     for( var msg in snapshot.docs){
       print(msg.data());
     }
    }
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
        title: Text('Chat'),
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
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      //messageBody + loggedInUser.email
                      _firestore.collection("messages").add({
                        'body': messageBody,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
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
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            );
          }
          final msgs = snapshot.data.docs;
          List<MsgBubble>  messageBubbles =[];
          for (var msg in msgs){
            final msgtext = msg.data()['body'];
            final msgsender = msg.data()['sender'];

            final messageBubble = MsgBubble(
              sender: msgsender,
              body: msgtext,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubbles,
            ),
          );
        }

    );
  }
}

class MsgBubble extends StatelessWidget {
  MsgBubble({this.sender, this.body});
  final String sender;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(sender, style: TextStyle(
            fontSize: 12.0,
            color: Colors.white60
          ),),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 6.0,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$body',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
    );



  }
}
