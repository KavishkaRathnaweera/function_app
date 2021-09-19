import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Data extends ChangeNotifier {
  Set<Marker> markers = {
    Marker(markerId: MarkerId('1'), position: LatLng(7.0246668, 79.9671238)),
    Marker(markerId: MarkerId('2'), position: LatLng(7.0236778, 79.9682180)),
    Marker(markerId: MarkerId('3'), position: LatLng(7.0266599, 79.9693317)),
    Marker(markerId: MarkerId('4'), position: LatLng(7.0246720, 79.9673250)),
    Marker(markerId: MarkerId('5'), position: LatLng(7.0226655, 79.9662115)),
  };

  List<Text> scannedList = [];
}

/*
Provider.of<TaskData>(context, listen: false).addTask(taskName)
 */
