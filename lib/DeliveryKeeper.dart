import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Components/DrawerChildDelivery.dart';
import 'package:function_app/Components/TextWrite.dart';

import 'Views/loginScreen.dart';

class DeliveryScreen extends StatefulWidget {
  static final String screenId = 'deliveryScreen';

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      Navigator.popUntil(
          context, ModalRoute.withName('${LoginScreen.screenId}'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Log Keeper'),
      ),
      drawer: Drawer(
        child: DrawerChildDelivery(),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWriteWidget(
                'This is Delivery Log Keeper view.There are two main functions.',
                20.0),
            SizedBox(height: 10.0),
            TextWriteWidget('1) Scan Post Packages', 15.0),
            TextWriteWidget('2) View Scanned Packages', 15.0),
          ],
        ),
      ),
    );
  }
}
