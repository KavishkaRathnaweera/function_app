import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/Components/CurrentLocation.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Services/NetworkServices.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class AddAddress extends StatefulWidget {
  static final String screenId = 'AddAddressScreen';

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool showSpinner = false;
  final TextEditingController textEditingControllerLat =
      TextEditingController();
  final TextEditingController textEditingControllerLong =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _coordKey = GlobalKey<FormState>();
  AddressSelection _selection = AddressSelection.Manual;
  bool coordinatesEnabled = true;
  late String longitude;
  late String latitude;
  late String addressNum;
  late String street1;
  late String street2 = '';
  late String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ADDRESS'),
      ),
      drawer: Drawer(
        child: DrawerChild(),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: cursorColor,
        ),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: ListView(
              padding: EdgeInsets.only(top: 10.0),
              children: [
                Text(
                  'Address No',
                  style: kTextFieldStyle,
                ),
                TextFormField(
                  onChanged: (value) {
                    addressNum = value;
                  },
                  style: kTextFieldType,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: cursorColor,
                  decoration: buildInputDecoration(
                      'address number here (Ex : 158/A/1 , 256/4)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Street 1',
                  style: kTextFieldStyle,
                ),
                TextFormField(
                  onChanged: (value) {
                    street1 = value;
                  },
                  style: kTextFieldType,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: cursorColor,
                  decoration: buildInputDecoration(
                      'street name only (Ex : jaya , baseline)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Street 2',
                  style: kTextFieldStyle,
                ),
                TextFormField(
                  onChanged: (value) {
                    street2 = value;
                  },
                  style: kTextFieldType,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: cursorColor,
                  decoration: buildInputDecoration(
                      'street 2 name only (Ex : lotus) (optional)'),
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'City',
                  style: kTextFieldStyle,
                ),
                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  style: kTextFieldType,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: cursorColor,
                  decoration: buildInputDecoration('city name here'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Coordinates',
                  style: kTextFieldStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RadioListTile<AddressSelection>(
                  title: Text(
                    'Add Coordinates Manually',
                    style: kTextFieldStyleRad,
                  ),
                  activeColor: cursorColor,
                  value: AddressSelection.Manual,
                  groupValue: _selection,
                  onChanged: (AddressSelection? value) {
                    setState(() {
                      _selection = value!;
                      coordinatesEnabled = true;
                      latitude = longitude = '';
                      textEditingControllerLat.value = TextEditingValue.empty;
                      textEditingControllerLong.value = TextEditingValue.empty;
                    });
                  },
                ),
                RadioListTile<AddressSelection>(
                  title: Text(
                    'Get Coordinates from mobile',
                    style: kTextFieldStyleRad,
                  ),
                  activeColor: cursorColor,
                  value: AddressSelection.FromMap,
                  groupValue: _selection,
                  onChanged: (AddressSelection? value) async {
                    var loc;
                    try {
                      loc = await CurrentLocation.getCurrentLocation(context);
                    } catch (e) {}
                    setState(() {
                      coordinatesEnabled = false;
                      _selection = value!;
                      //coordinatesEnabled = false;
                      if (loc != null) {
                        latitude = loc.latitude.toString();
                        longitude = loc.longitude.toString();
                        textEditingControllerLat.value =
                            TextEditingValue(text: 'Latitude : $latitude');
                        textEditingControllerLong.value =
                            TextEditingValue(text: 'Longitude :  $longitude');
                      }
                    });
                  },
                ),
                Form(
                    key: _coordKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            latitude = value;
                          },
                          keyboardType: TextInputType.number,
                          enabled: coordinatesEnabled,
                          textAlignVertical: TextAlignVertical.bottom,
                          cursorColor: cursorColor,
                          style: kTextFieldType,
                          controller: textEditingControllerLat,
                          decoration: buildInputDecoration('latitude'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter value';
                            }
                            try {
                              double latitudeValue = double.parse(value);
                              if (latitudeValue < -90.001 ||
                                  latitudeValue > 90.001) {
                                return 'Incorrect latitude value';
                              }
                            } catch (e) {
                              return 'Invalid input';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            longitude = value;
                          },
                          keyboardType: TextInputType.number,
                          enabled: coordinatesEnabled,
                          textAlignVertical: TextAlignVertical.bottom,
                          cursorColor: cursorColor,
                          style: kTextFieldType,
                          controller: textEditingControllerLong,
                          decoration: buildInputDecoration('longitude'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            try {
                              double latitudeValue = double.parse(value);
                              if (latitudeValue < -180.001 ||
                                  latitudeValue > 180.001) {
                                return 'Incorrect longitude value';
                              }
                            } catch (e) {
                              return 'Invalid input';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                ReusableButton(
                    buttonColor: Colors.black54,
                    onPressed: () async {
                      await handlePress(coordinatesEnabled);
                    },
                    label: 'Submit')
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(labelName) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF111a2b)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade900),
      ),
      hintText: labelName,
      //labelText: labelName,
      // labelStyle: TextStyle(color: Colors.white),
      // filled: true
    );
  }

  handlePress(bool enabled) async {
    if (enabled) {
      if (_formKey.currentState!.validate() &&
          _coordKey.currentState!.validate()) {
        try {
          await NetworkService().addAddress(addressNum, street1, street2, city,
              double.parse(latitude), double.parse(longitude), true);
          AlertBox.showMyDialog(
              context, 'Successful!', 'Address added/updated to the system',
              () {
            Navigator.pop(context);
          }, Colors.green[900]);
        } catch (e) {
          print(e);
          AlertBox.showMyDialog(context, 'Failed!',
              'Procedure failed. please check internet connection', () {
            Navigator.pop(context);
          }, Colors.red[900]);
        }
      }
    } else {
      if (_formKey.currentState!.validate()) {
        try {
          await NetworkService().addAddress(addressNum, street1, street2, city,
              double.parse(latitude), double.parse(longitude), true);
          AlertBox.showMyDialog(
              context, 'Successful!', 'Address added/updated to the system',
              () {
            Navigator.pop(context);
          }, Colors.green[900]);
        } catch (e) {
          print(e);
          AlertBox.showMyDialog(context, 'Failed!',
              'Procedure failed. please check internet connection', () {
            Navigator.pop(context);
          }, Colors.red[900]);
        }
      }
    }
  }

  static const kTextFieldType = TextStyle(
      fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.w500);
  static const kTextFieldStyle = TextStyle(
      fontSize: 20.0, color: Colors.grey, fontWeight: FontWeight.w900);
  static const kTextFieldStyleRad = TextStyle(
      fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w900);
  static const cursorColor = Color(0xFFa01b0f);
}
