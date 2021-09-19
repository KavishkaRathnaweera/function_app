import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:function_app/Views/BarcodeScreen.dart';
import 'package:function_app/Views/ScannedBarcode.dart';
import 'package:function_app/DeliveryKeeper.dart';
import 'package:function_app/Views/loginScreen.dart';

class DrawerChildDelivery extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final double tSize = 15.0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, DeliveryScreen.screenId);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red.shade900)),
          child: DrawerHeader(
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
                  'Delivery Log Keeper',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
        ListTile(
          title: TextWriteWidget('Scan Barcode', tSize),
          leading: Icon(FontAwesomeIcons.barcode),
          onTap: () {
            Navigator.pushNamed(context, BarcodeScreen.screenId);
          },
        ),
        ListTile(
          title: TextWriteWidget('Scanned Items', tSize),
          leading: Icon(
            Icons.search,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pushNamed(context, ScannedBarcode.screenId);
            //Navigator.pop(context);
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
            Navigator.pop(context);
            Navigator.pushNamed(context, LoginScreen.screenId);
            //Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
