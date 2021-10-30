import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  static final String screenId = 'servSignatureScreen';

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  late SignatureController control;

  @override
  void initState() {
    control = SignatureController(penStrokeWidth: 3, penColor: Colors.white);
    super.initState();
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  void cancelButton() {
    setState(() {
      control.clear();
    });
  }

  void acceptButton() async {
    final signatureObject = await control.toPngBytes();
    if (signatureObject != null) {
      Navigator.pop(context, signatureObject);
    }

    //return signatureObject;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: TextButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text(
            'Signature',
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Signature(
                controller: control,
                backgroundColor: Colors.black12,
              ),
            ),
            Container(
              color: Colors.black,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PressButton(
                      key: Key('acceptButton'),
                      label: 'Accept',
                      color: Colors.green,
                      iconData: Icons.check,
                      onpressed: () => acceptButton,
                    ),
                  ),
                  Expanded(
                    child: PressButton(
                      key: Key('clearButton'),
                      label: 'Clear',
                      color: Colors.red,
                      iconData: Icons.clear,
                      onpressed: () => cancelButton,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PressButton extends StatelessWidget {
  PressButton(
      {required this.label,
      required this.color,
      required this.iconData,
      required this.onpressed,
      required this.key});
  final Function onpressed;
  final Color color;
  final IconData iconData;
  final String label;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label',
            style: TextStyle(color: color),
          ),
          SizedBox(width: 10.0),
          Icon(
            iconData,
            color: color,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
