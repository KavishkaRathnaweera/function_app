import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/Data.dart';
import 'package:function_app/Components/DrawerChildDelivery.dart';

class BarcodeScreen extends StatefulWidget {
  static final String screenId = 'servBarcodeScreen';

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  String _scanBarcode = 'No item scanned';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      changeHandle(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  changeHandle(inputBarcode) {
    print(
        'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    print(inputBarcode);
    Provider.of<Data>(context, listen: false)
        .scannedList
        .add(Text('$inputBarcode'));
    setState(() {
      // if (_scanBarcode.contains('No item scanned')) {
      //   _scanBarcode.remove('No item scanned');
      // }
      _scanBarcode = inputBarcode;
      print(_scanBarcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Packages'),
      ),
      drawer: Drawer(
        child: DrawerChildDelivery(),
      ),
      body: Container(
        margin: EdgeInsets.all(50.0),
        child: ListView(
          children: [
            Container(
              //padding: EdgeInsets.only(),
              alignment: Alignment.center,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => scanBarcodeNormal(),
                      child: Text('Scan'),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => startBarcodeScanStream(),
                      child: Text('Scan batch'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Scanned Barcode :',
              style: TextStyle(fontSize: 20.0),
            ),
            ListTile(
              title: Text('$_scanBarcode'),
            ),
            // Container(
            //   child: ListView(
            //     children: [
            //
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// children: <Widget>[
// ElevatedButton(
// onPressed: () => scanBarcodeNormal(),
// child: Text('Start barcode scan')),
// ElevatedButton(
// onPressed: () => startBarcodeScanStream(),
// child: Text('Start barcode scan stream')),
// Text('Scan result : $_scanBarcode\n', style: TextStyle(fontSize: 20))
// ],
