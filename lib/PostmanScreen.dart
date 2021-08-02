import 'package:flutter/material.dart';

import 'Constants/DrawerChild.dart';

class PostmanScreen extends StatelessWidget {
  static final String screenId = 'postmanScreen';

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
        child: Text('hiii'),
      ),
    );
  }
}
