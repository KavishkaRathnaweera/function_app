import 'package:flutter/material.dart';

class DrawerChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Column(
            children: [
              CircleAvatar(
                child: Image.asset('images/postman.png'),
                maxRadius: 50.0,
              ),
              Text(
                'Postman',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              )
            ],
          ),
        ), //Image.asset('images/postman.png')
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            Navigator.pop(context);
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }
}
