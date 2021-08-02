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
    control = SignatureController(
      penStrokeWidth: 5,
    );
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
      showModalBottomSheet(
        context: context,
        builder: (context) {
          //return Provider.value(value: myModel, child: BottomSheetCreate());
          return Column(children: [
            Image.memory(signatureObject),
            Row(
              children: [
                TextButton(onPressed: () {}, child: Text('Add')),
                TextButton(onPressed: () {}, child: Text('Reject')),
              ],
            )
          ]);
        },
        isScrollControlled: true,
      );
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
                backgroundColor: Colors.white,
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
                      label: 'Accept',
                      color: Colors.green,
                      iconData: Icons.check,
                      onpressed: () => acceptButton,
                    ),
                  ),
                  Expanded(
                    child: PressButton(
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
      required this.onpressed});
  final Function onpressed;
  final Color color;
  final IconData iconData;
  final String label;

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
