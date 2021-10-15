import 'package:flutter/material.dart';
import 'package:function_app/Services/LocationServices.dart';
import 'package:geolocator/geolocator.dart';
import 'Alerts.dart';
import 'ConstantFile.dart';

class CurrentLocation {
  static Future<dynamic> getCurrentLocation(context) async {
    try {
      Position initLocation =
          await LocationService.getPosition(LocationConstant.CurrentPosition);
      return initLocation;
    } on LocationServiceDisabledException catch (e) {
      print('hello,location serivce disables');
      AlertBox.showMyDialog(context, 'Location Service is Disabled',
          'Please on Location on your phone', () {
        Navigator.pop(context);
      }, Colors.orange[900]);
    } on PermissionDeniedException catch (e) {
      print('permission denied');
      AlertBox.showMyDialog(context, 'Location Denied in your phone',
          'Please give permission to the Application', () {
        Navigator.pop(context);
        // Navigator.popUntil(
        //     context, ModalRoute.withName('$screen'));
      }, Colors.red[900]);
    } on DeniedForeverException catch (e) {
      print('permission forever denied');
      AlertBox.showMyDialog(context, 'Location Denied in your phone',
          'Please give permission to the Application', () {
        Navigator.pop(context);
      }, Colors.orange[900]);
    } catch (e) {
      print(e);
      AlertBox.showMyDialog(context, 'Something went Wrong!!!!!',
          'Please check your Mobile Location Service', () {
        Navigator.pop(context);
      }, Colors.orange[900]);
    }
  }
}
