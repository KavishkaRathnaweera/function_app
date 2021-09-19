import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:function_app/Components/TextWrite.dart';

import 'Components/DrawerChild.dart';

class PostmanScreen extends StatelessWidget {
  static final String screenId = 'postmanScreen';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postman'),
      ),
      drawer: Drawer(
        child: DrawerChild(),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWriteWidget(
                'This is postman view.There are six main functions for postman',
                20.0),
            SizedBox(height: 10.0),
            TextWriteWidget('1) Normal post handling', 15.0),
            TextWriteWidget('2) Registered post handling', 15.0),
            TextWriteWidget('3) Package post handling', 15.0),
            TextWriteWidget('4) View map details', 15.0),
            TextWriteWidget('5) Add address to system', 15.0),
          ],
        ),
      ),
    );
  }
}

/*
 return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                messageStream();
                _auth.signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, LoginScreen.screenId);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
 */
