import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScreen extends StatefulWidget {
  static final String screenId = 'servBarcodeScreen';

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  List _scanBarcode = ['No item scanned'];

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    setState(() {
      if (_scanBarcode.contains('No item scanned')) {
        _scanBarcode.remove('No item scanned');
      }
      _scanBarcode.add(barcodeScanRes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
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
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: _scanBarcode[index],
                );
              },
              itemCount: _scanBarcode.length,
            ),
          ),
        ],
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
