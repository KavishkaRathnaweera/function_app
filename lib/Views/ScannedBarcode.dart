import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:function_app/Components/DrawerChildDelivery.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/Data.dart';

class ScannedBarcode extends StatelessWidget {
  static final String screenId = 'ScannedBarcodes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Barcodes'),
      ),
      drawer: Drawer(
        child: DrawerChildDelivery(),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Consumer<Data>(
          builder: (context, scanneddata, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: scanneddata.scannedList[index],
                );
              },
              itemCount: scanneddata.scannedList.length,
            );
          },
        ),
      ),
    );
  }
}
