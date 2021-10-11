import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'TextWrite.dart';

class SignatureTile extends StatelessWidget {
  SignatureTile({this.signature});
  final signature;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(FontAwesomeIcons.pen),
      title: TextWriteWidget('Signature', 20.0),
      subtitle: Image.memory(
        signature,
        height: 50.0,
      ),
    );
  }
}
