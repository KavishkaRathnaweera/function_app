import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton(
      {required this.buttonColor,
      required this.onPressed,
      required this.label});

  Color buttonColor;
  Function onPressed;
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();

            ///Navigator.pushNamed(context, LoginScreen.screenId);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
