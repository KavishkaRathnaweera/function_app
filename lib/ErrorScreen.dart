import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/wrongC.png',
              height: 50,
              width: 50,
            ),
            Text(
              'Something Went Wrong',
              style: TextStyle(color: Colors.red[900], height: 10),
            )
          ],
        ),
      ),
    );
  }
}
