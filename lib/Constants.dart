import 'package:flutter/material.dart';

const kTextDecoration = InputDecoration(
  fillColor: Color.fromRGBO(30, 30, 30, 0.7),
  filled: true,
  hintText: 'Enter the value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kTextFieldDecoration = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const kactiveCardColor = Colors.black; //Color(0xFF1D1E33);
const kinactiveCardColor = Colors.black54; //Color(0xFF111126);
const kbottomBarHeight = 80.0;
const kbottomBarColor = Color(0xFFEB1555);

const klabelTextStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: 18.0,
);

const knumberTextStyle = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.w900,
);

enum Gender {
  Male,
  Female,
}
