import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:function_app/Services/LocationServices.dart';
import 'package:function_app/Constants/LocationConstants.dart';
import 'package:function_app/Views/loginScreen.dart';

class GoogleMapScreen extends StatefulWidget {
  static final String screenId = 'servGoogleMapScreen';

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  late LatLng latitudeLongitude = LatLng(6.927079, 79.861244);
  late LatLng currentCordinates;
  Set<Marker> markers = {};

  getCurrentLocation() async {
    try {
      Position initLocation =
          await LocationService.getPosition(LocationConstant.CurrentPosition);
      currentCordinates = LatLng(initLocation.latitude, initLocation.longitude);
      mapController.moveCamera(CameraUpdate.newLatLng(currentCordinates));
      setState(() {
        var mark = Marker(
          markerId: MarkerId('Current'),
          position: LatLng(initLocation.latitude, initLocation.longitude),
        );
        markers.add(mark);
      });
    } on LocationServiceDisabledException catch (e) {
      dialogLocationError(
          'Location disabled in your phone', 'Please on location');
      print('hello,location serivce desables');
    } on PermissionDeniedException catch (e) {
      dialogLocationError('Location Denied in your phone',
          'Please give permission to the Application');
      print('permission denied');
    } on DeniedForeverException catch (e) {
      dialogLocationError('Location Denied in your phone',
          'Please give permission to the Application');
      print('permission forever denied');
    } catch (e) {
      print(e);
      dialogLocationError('Something went Wrong!!!!!',
          'Please check your Mobile Location Service');
    }
  }

  Future<dynamic> dialogLocationError(String title, String body) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('$title'),
        content: Text('$body'),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.popUntil(
                  context, ModalRoute.withName(LoginScreen.screenId))
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void onMapCreatedFunction(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: onMapCreatedFunction,
          initialCameraPosition: CameraPosition(
            target: latitudeLongitude,
            zoom: 18.0,
          ),
          markers: markers,
        ),
      ),
    );
  }
}
