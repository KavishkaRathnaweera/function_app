import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Components/DrawerChildDelivery.dart';
import 'package:function_app/Components/TextWrite.dart';

import 'Constants.dart';
import 'Views/loginScreen.dart';

class DeliveryScreen extends StatefulWidget {
  static final String screenId = 'deliveryScreen';

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString()
          .substring(0, 10);

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
      key: Key('deliverScafKey'),
      appBar: AppBar(
        title: Text('Delivery Log Keeper'),
      ),
      drawer: Drawer(
        child: DrawerChildDelivery(),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.black12,
              child:
                  Center(child: TextWriteWidget('Scanning Date ${date}', 20.0)),
            ),
            Expanded(
                child: Icon(
              Icons.search,
              size: 300,
            ))
          ],
        ),
      ),
    );
  }
}
