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
    borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffD32F2F), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
