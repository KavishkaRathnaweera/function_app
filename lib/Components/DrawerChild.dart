import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:function_app/StateManagement/Data.dart';
import 'package:function_app/Views/GoogleMapScreen.dart';
import 'package:function_app/Views/AddressScreen.dart';
import 'package:function_app/Views/RemainingPostScreen.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Views/UndelivarablePostScreen.dart';
import 'package:function_app/Views/DeliveredPostScreen.dart';
import 'package:provider/provider.dart';

class DrawerChild extends StatefulWidget {
  @override
  _DrawerChildState createState() => _DrawerChildState();
}

class _DrawerChildState extends State<DrawerChild> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<int> list_items = [1, 2, 3];

  final double tSize = 15.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName('${PostmanScreen.screenId}'));
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red.shade900)),
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red[900],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Image.asset('images/postman.png'),
                      maxRadius: 50.0,
                    ),
                    Text(
                      'POSTMAN',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              Text(
                'Name   : ${Provider.of<DeliveryData>(context, listen: false).userDetails.firstName} '
                '${Provider.of<DeliveryData>(context, listen: false).userDetails.lastName}',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.0,
                    color: Colors.black),
              ),
              Text(
                'NIC No : ${Provider.of<DeliveryData>(context, listen: false).userDetails.nic}',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.0,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        ExpansionTile(
          title: TextWriteWidget('Normal Post', tSize),
          leading: Icon(
            Icons.local_post_office_rounded,
            size: 25.0,
          ),
          children: <Widget>[
            ListTile(
              title: Text('Remaining Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, RemainingPostScreen.screenId,
                    arguments: PostType.NormalPost);
              },
            ),
            ListTile(
              title: Text('Delivered Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, DeliveredPostScreen.screenId,
                    arguments: PostType.NormalPost);
              },
            ),
            ListTile(
              title: Text('Undeliverable Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, UndeliverablePostScreen.screenId,
                    arguments: PostType.NormalPost);
              },
            ),
          ],
        ),
        ExpansionTile(
          title: TextWriteWidget('Registered post', tSize),
          leading: Icon(
            Icons.post_add_rounded,
            size: 30.0,
          ),
          children: <Widget>[
            ListTile(
              title: Text('Remaining Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, RemainingPostScreen.screenId,
                    arguments: PostType.RegisteredPost);
              },
            ),
            ListTile(
              title: Text('Delivered Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, DeliveredPostScreen.screenId,
                    arguments: PostType.RegisteredPost);
              },
            ),
            ListTile(
              title: Text('Undeliverable Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, UndeliverablePostScreen.screenId,
                    arguments: PostType.RegisteredPost);
              },
            ),
          ],
        ),
        ExpansionTile(
          title: TextWriteWidget('Package Post', tSize),
          leading: Icon(FontAwesomeIcons.mailBulk),
          children: <Widget>[
            ListTile(
              title: Text('Remaining Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, RemainingPostScreen.screenId,
                    arguments: PostType.Package);
              },
            ),
            ListTile(
              title: Text('Delivered Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, DeliveredPostScreen.screenId,
                    arguments: PostType.Package);
              },
            ),
            ListTile(
              title: Text('Undeliverable Posts'),
              leading: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, UndeliverablePostScreen.screenId,
                    arguments: PostType.Package);
              },
            ),
          ],
        ),
        ListTile(
          title: TextWriteWidget('View Map', tSize),
          leading: Icon(FontAwesomeIcons.mapMarkedAlt),
          onTap: () {
            Navigator.pushNamed(context, GoogleMapScreen.screenId);
          },
        ),
        ListTile(
          title: TextWriteWidget('Add Address', tSize),
          leading: Icon(FontAwesomeIcons.home),
          onTap: () {
            Navigator.pushNamed(context, AddAddress.screenId);
            // ...
          },
        ),
        ListTile(
          title: TextWriteWidget('Logout', tSize),
          leading: Icon(
            Icons.logout,
            size: 30.0,
          ),
          onTap: () {
            _auth.signOut();
            // Navigator.pop(context);
            // Navigator.pushNamed(context, LoginScreen.screenId);
            Navigator.popUntil(
                context, ModalRoute.withName('${LoginScreen.screenId}'));
          },
        ),
      ],
    );
  }
}

/*
 Navigator.pushNamedAndRemoveUntil(
                context, pageD, ModalRoute.withName(pageB));
 */
