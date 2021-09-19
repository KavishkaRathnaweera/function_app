import 'package:flutter/material.dart';

class TextWriteWidget extends StatelessWidget {
  TextWriteWidget(this.bodytext, this.fsize);

  final String bodytext;
  final double fsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$bodytext',
      style: TextStyle(fontSize: fsize),
    );
  }
}
