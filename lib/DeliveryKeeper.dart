import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Components/DrawerChildDelivery.dart';
import 'package:function_app/Components/TextWrite.dart';

class DeliveryScreen extends StatelessWidget {
  static final String screenId = 'deliveryScreen';

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
