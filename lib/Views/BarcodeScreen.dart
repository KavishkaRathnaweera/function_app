import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Components/CurrentLocation.dart';
import 'package:function_app/Module/Bundle.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/Data.dart';
import 'package:function_app/Components/DrawerChildDelivery.dart';

class BarcodeScreen extends StatefulWidget {
  static final String screenId = 'servBarcodeScreen';

  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  Map<String, bool> barcodeMap = {};
  var screenSize;
  bool selectButtonPressed = false;
  bool showSpinner = false;
  bool buttonEnable = false;

  void initState() {
    Provider.of<DeliveryData>(context, listen: false)
        .scannedList
        .forEach((element) {
      barcodeMap[element.barcode] = false;
    });
    print(barcodeMap);
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    try {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
              '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
          .listen((barcode) => changeHandle(barcode));
    } catch (e) {}
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
    Provider.of<DeliveryData>(context, listen: false).addToBundleList(
        Bundle(barcode: inputBarcode, dateTime: DateTime.now()));
  }

  selectButton() {
    if (selectButtonPressed) {
      setState(() {
        Provider.of<DeliveryData>(context, listen: false)
            .scannedList
            .forEach((element) {
          barcodeMap[element.barcode] = true;
        });
      });
    } else {
      setState(() {
        Provider.of<DeliveryData>(context, listen: false)
            .scannedList
            .forEach((element) {
          barcodeMap[element.barcode] = false;
        });
        buttonEnable = false;
      });
    }
    buttonControl();
  }

  locationUpdation(bool isDestination) async {
    List<String> failedList = [];
    List<Bundle> passed = [];
    var loc;

    try {
      setState(() {
        showSpinner = true;
      });
      loc = await CurrentLocation.getCurrentLocation(context);
      if (loc != null) {
        await Future.forEach(
            Provider.of<DeliveryData>(context, listen: false).scannedList,
            (element) async {
          element as Bundle;
          if (barcodeMap[element.barcode] == true) {
            DatabaseResult result =
                await element.updateLocation(loc, isDestination);
            if (result == DatabaseResult.Failed) {
              failedList.add(element.barcode);
              print(failedList);
            } else if (result == DatabaseResult.Success) {
              passed.add(element);
            }
          }
        });
        setState(() {
          showSpinner = false;
        });
        if (failedList.isNotEmpty) {
          AlertBox.showMyDialog(context, 'Failed',
              'Following Bundles are failed to upload \n${failedList.join(",")}',
              () {
            Navigator.pop(context);
          }, Colors.red[900]);
        } else {
          passed.forEach((element) {
            Provider.of<DeliveryData>(context, listen: false)
                .removeFromBundleList(element);
            barcodeMap.remove(element.barcode);
          });
          AlertBox.showMyDialog(context, 'Success', 'All bundles are updated',
              () {
            Navigator.pop(context);
          }, Colors.green[900]);
        }
      }
    } catch (e) {
      AlertBox.showMyDialog(
          context, 'Error!', 'Please check you network connection', () {
        Navigator.pop(context);
      }, Colors.red[900]);
    } finally {
      buttonControl();
    }
  }

  confirmBox(BuildContext context, bool isDestination) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    print(isDestination);
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        locationUpdation(isDestination);
      },
    );
    print(isDestination);
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: (isDestination)
          ? Text("Destination Arrived", style: kConfirmButtonStyle())
          : Text('Location Update', style: kConfirmButtonStyle()),
      content: Text(
          "Please make sure you have selected correct bundles \n\nNote: This process might take a while"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    print(isDestination);
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  buttonControl() {
    if (barcodeMap.values.any((element) => element == true)) {
      buttonEnable = true;
    } else {
      buttonEnable = false;
    }
  }

  rejectTile(Bundle bundleItem) {
    Provider.of<DeliveryData>(context, listen: false)
        .removeFromBundleList(bundleItem);
    barcodeMap.remove(bundleItem.barcode);
    buttonControl();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    bool heightBool = (screenSize.height < 715);
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Packages'),
      ),
      drawer: Drawer(
        child: DrawerChildDelivery(),
      ),
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Colors.red.shade900,
        ),
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Scan Options',
                      style: topicSize(),
                    ),
                  ),
                  SizedBox(
                    height: heightBool ? 20.0 : 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => scanBarcodeNormal(),
                          child: Text('Single Scan'),
                          style: scanButtonStyle(),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => startBarcodeScanStream(),
                          child: Text('Batch Scan'),
                          style: scanButtonStyle(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightBool ? 10.0 : 20.0,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        selectButtonPressed = !selectButtonPressed;
                        selectButton();
                      },
                      child: Text(
                        'Scanned Barcodes',
                        style: topicSize(),
                      ),
                    ),
                  ),
                  SizedBox(height: heightBool ? 7.0 : 10.0),
                  Container(
                    constraints:
                        BoxConstraints(maxHeight: heightBool ? 300.0 : 500),
                    child: Consumer<DeliveryData>(
                      builder: (context, scanData, child) {
                        List<Bundle> scannedList = scanData.scannedList;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: scanData.scannedList.length,
                          itemBuilder: (context, index) {
                            final Bundle bundleItem = scannedList[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: Text('${bundleItem.barcode}',
                                      style: TextStyle(
                                          fontSize: heightBool ? 12.0 : 15.0)),
                                  subtitle: Text('${bundleItem.dateTime}',
                                      style: TextStyle(
                                          fontSize: heightBool ? 12.0 : 15.0)),
                                  onLongPress: () => rejectTile(bundleItem),
                                  trailing: Checkbox(
                                    onChanged: (bool? value) {
                                      setState(() {
                                        barcodeMap[bundleItem.barcode] = value!;
                                        buttonControl();
                                      });
                                    },
                                    checkColor: Colors.red,
                                    activeColor: Colors.black,
                                    value:
                                        (barcodeMap[bundleItem.barcode] == null)
                                            ? false
                                            : barcodeMap[bundleItem.barcode],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          (buttonEnable) ? confirmBox(context, false) : null,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on),
                            Text('Location')
                          ]),
                      style: scanButtonStyle(),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          (buttonEnable) ? confirmBox(context, true) : null,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.home), Text('Destination')]),
                      style: scanButtonStyle(),
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

  final kScanButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all<double>(6.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade900),
    textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
        color: Colors.red,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w900,
        letterSpacing: 1.0)),
  );
  final kTextFieldStyle = TextStyle(
      fontSize: 25.0,
      color: Colors.grey,
      fontWeight: FontWeight.w900,
      letterSpacing: 2.0);

  topicSize() {
    return TextStyle(
        fontSize: (screenSize.height < 715) ? 20.0 : 25.0,
        color: Colors.grey,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0);
  }

  scanButtonStyle() {
    return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(6.0),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
          color: Colors.red,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w900,
          fontSize: (screenSize.height < 715) ? 12.0 : 15.0,
          letterSpacing: 1.0)),
    );
  }

  kConfirmButtonStyle() {
    return TextStyle(
      fontSize: (screenSize.height < 715) ? 15.0 : 20.0,
      color: Colors.red[900],
      fontWeight: FontWeight.bold,
    );
  }
}
