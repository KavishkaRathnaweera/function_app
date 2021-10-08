import 'package:flutter/material.dart';
import 'package:function_app/Constants.dart';

class reusableIconText extends StatelessWidget {
  reusableIconText(
      {required this.name, required this.number, required this.color});
  final String name;
  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$number',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          name,
          style: TextStyle(
            color: color,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
