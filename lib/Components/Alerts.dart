import 'package:flutter/material.dart';

class AlertBox {
  static Future<void> showMyDialog(
      context, title, bodyText, pressed, headColor) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$title',
            style: TextStyle(fontSize: 35, color: headColor),
          ),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  '$bodyText',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Okay',
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              onPressed: () {
                pressed();
              },
            ),
          ],
        );
      },
    );
  }
}
