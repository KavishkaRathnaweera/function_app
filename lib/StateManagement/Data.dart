import 'package:flutter/cupertino.dart';
import 'package:function_app/Module/Bundle.dart';
import 'package:function_app/Module/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryData extends ChangeNotifier {
  late AppUser userDetails;
  List<Bundle> _scannedList = [];

  List<Bundle> get scannedList => _scannedList;

  addToBundleList(Bundle bundle) {
    bool isScanned = false;
    _scannedList.forEach((element) {
      if (element.barcode == bundle.barcode) {
        isScanned = true;
      }
    });
    if (!isScanned) {
      _scannedList.add(bundle);
    }
    notifyListeners();
  }

  removeFromBundleList(Bundle bundle) {
    _scannedList.remove(bundle);
    notifyListeners();
  }
}

/*
Provider.of<TaskData>(context, listen: false).addTask(taskName)
 */

/*
    // Marker(markerId: MarkerId('1'), position: LatLng(7.0246668, 79.9671238)),
    // Marker(markerId: MarkerId('2'), position: LatLng(7.0236778, 79.9682180)),
    // Marker(markerId: MarkerId('3'), position: LatLng(7.0266599, 79.9693317)),
    // Marker(markerId: MarkerId('4'), position: LatLng(7.0246720, 79.9673250)),
    // Marker(markerId: MarkerId('5'), position: LatLng(7.0226655, 79.9662115)),
 */
