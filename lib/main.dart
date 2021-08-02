import 'package:flutter/material.dart';
import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/Views/SignatureView.dart';
import 'package:function_app/Views/BarcodeScreen.dart';
import 'package:function_app/Views/GoogleMapScreen.dart';
import 'package:function_app/PostmanScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FUnctions App',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.red[900],
        accentColor: Colors.red[100],
        fontFamily: 'Georgia',
      ),
      initialRoute: LoginScreen.screenId,
      routes: {
        GoogleMapScreen.screenId: (context) => GoogleMapScreen(),
        LoginScreen.screenId: (context) => LoginScreen(),
        PostmanScreen.screenId: (context) => PostmanScreen(),
      },
    );
  }
}
