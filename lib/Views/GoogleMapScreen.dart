import 'dart:async';
import 'package:flutter/material.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:function_app/Services/LocationServices.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/StateManagement/Data.dart';

class GoogleMapScreen extends StatefulWidget {
  static final String screenId = 'servGoogleMapScreen';

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  late LatLng latitudeLongitude = LatLng(6.927079, 79.861244);
  late LatLng currentCordinates;

  void initState() {
    getMapLocation();
    getCurrentLocation();
    super.initState();
  }

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
        //Provider.of<PostData>(context, listen: false).markers.add(mark);
      });
    } on LocationServiceDisabledException catch (e) {
      print('hello,location serivce disables');
      AlertBox.showMyDialog(context, 'Location Service is Disabled',
          'Please on Location on your phone', () {
        Navigator.popUntil(
            context, ModalRoute.withName('${PostmanScreen.screenId}'));
      }, Colors.red[900]);
    } on PermissionDeniedException catch (e) {
      print('permission denied');
      AlertBox.showMyDialog(context, 'Location Denied in your phone',
          'Please give permission to the Application', () {
        Navigator.popUntil(
            context, ModalRoute.withName('${PostmanScreen.screenId}'));
      }, Colors.red[900]);
    } on DeniedForeverException catch (e) {
      print('permission forever denied');
      AlertBox.showMyDialog(context, 'Location Denied in your phone',
          'Please give permission to the Application', () {
        Navigator.popUntil(
            context, ModalRoute.withName('${PostmanScreen.screenId}'));
      }, Colors.red[900]);
    } catch (e) {
      print(e);
      AlertBox.showMyDialog(context, 'Something went Wrong!!!!!',
          'Please check your Mobile Location Service', () {
        Navigator.popUntil(
            context, ModalRoute.withName('${PostmanScreen.screenId}'));
      }, Colors.red[900]);
    }
  }

  getMapLocation() async {
    //print(Provider.of<PostData>(context, listen: false).getNormalPostList);
    Provider.of<PostData>(context, listen: false).addMarkerRemaining(
        Provider.of<PostData>(context, listen: false).getNormalPostList);
    Provider.of<PostData>(context, listen: false).addMarkerRemaining(
        Provider.of<PostData>(context, listen: false).getRegisteredPostList);
    Provider.of<PostData>(context, listen: false).addMarkerRemaining(
        Provider.of<PostData>(context, listen: false).getPackagePostList);
    Provider.of<PostData>(context, listen: false).addMarkerUndeliverable(
        Provider.of<PostData>(context, listen: false)
            .getNormalPostListUndelivereble);
    Provider.of<PostData>(context, listen: false).addMarkerUndeliverable(
        Provider.of<PostData>(context, listen: false)
            .getRegisteredPostListUndeliverable);
    Provider.of<PostData>(context, listen: false).addMarkerUndeliverable(
        Provider.of<PostData>(context, listen: false)
            .getPackagePostListUndeleverable);
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

  void onMapCreatedFunction(GoogleMapController controller) async {
    mapController = controller;
    getMapLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: GoogleMap(
          // mapType: MapType.hybrid,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: onMapCreatedFunction,
          initialCameraPosition: CameraPosition(
            target: latitudeLongitude,
            zoom: 18.0,
          ),
          markers: Provider.of<PostData>(context).markers,
        ),
      ),
    );
  }
}

/*
Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
 */
