import 'dart:core';
import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Constants.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Services/NetworkServices.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);
  static final String screenId = 'AddAddressScreen';

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  AddressSelection _selection = AddressSelection.Manual;
  bool coordinatesEnabled = true;
  late String longitude;
  late String latitude;
  late String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ADDRESS'),
      ),
      drawer: Drawer(
        child: DrawerChild(),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: ListView(
            padding: EdgeInsets.only(top: 10.0),
            children: [
              Text(
                'Address',
                style: kTextFieldDecoration,
              ),
              TextFormField(
                onChanged: (value) {
                  address = value;
                },
                style: TextStyle(fontFamily: 'Spartan MB'),
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: Colors.red,
                decoration: buildInputDecoration(''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Coordinates',
                style: kTextFieldDecoration,
              ),
              SizedBox(
                height: 10.0,
              ),
              RadioListTile<AddressSelection>(
                title: Text('Add Coordinate Manually'),
                activeColor: Colors.red,
                value: AddressSelection.Manual,
                groupValue: _selection,
                onChanged: (AddressSelection? value) {
                  setState(() {
                    _selection = value!;
                    coordinatesEnabled = true;
                  });
                },
              ),
              RadioListTile<AddressSelection>(
                title: Text('Select Coordinate from map'),
                activeColor: Colors.red,
                value: AddressSelection.FromMap,
                groupValue: _selection,
                onChanged: (AddressSelection? value) {
                  setState(() {
                    _selection = value!;
                    coordinatesEnabled = false;
                  });
                },
              ),
              TextFormField(
                onChanged: (value) {
                  latitude = value;
                },
                keyboardType: TextInputType.number,
                enabled: coordinatesEnabled,
                style: TextStyle(fontFamily: 'Spartan MB'),
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: Colors.red,
                decoration: buildInputDecoration('latitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter value';
                  }
                  try {
                    double latitudeValue = double.parse(value);
                    if (latitudeValue < -90.001 || latitudeValue > 90.001) {
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
                style: TextStyle(fontFamily: 'Spartan MB'),
                enabled: coordinatesEnabled,
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: Colors.red,
                decoration: buildInputDecoration('longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  try {
                    double latitudeValue = double.parse(value);
                    if (latitudeValue < -180.001 || latitudeValue > 180.001) {
                      return 'Incorrect latitude value';
                    }
                  } catch (e) {
                    return 'Invalid input';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ReusableButton(
                  buttonColor: Colors.black54,
                  onPressed: () async {
                    // await NetworkService().addAddress(
                    //     '78', 'matara', '', 'akuressa', 78.8888, 87.5685, true);
                  },
                  label: 'Submit')
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(labelName) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: labelName,
        hintStyle: TextStyle(fontFamily: 'Spartan MB')
        //labelText: labelName,
        // labelStyle: TextStyle(color: Colors.white),
        // filled: true
        );
  }
}
