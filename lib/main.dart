import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/Data.dart';

import 'package:function_app/Views/loginScreen.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/DeliveryKeeper.dart';
import 'package:function_app/ErrorScreen.dart';
import 'package:function_app/LoadingScreen.dart';

import 'package:function_app/Views/SignatureView.dart';
import 'package:function_app/Views/BarcodeScreen.dart';
import 'package:function_app/Views/GoogleMapScreen.dart';
import 'package:function_app/Views/AddressScreen.dart';
import 'package:function_app/Views/RemainingPostScreen.dart';
import 'package:function_app/Views/ScannedBarcode.dart';
import 'package:function_app/Views/UndelivarablePostScreen.dart';
import 'package:function_app/Views/DeliveredPostScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return WidgetsApp(
        builder: (context, int) {
          return SomethingWentWrong();
        },
        color: Colors.blue,
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return WidgetsApp(
        builder: (context, int) {
          return LoadingScreen();
        },
        color: Colors.blue,
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DeliveryData()),
        ChangeNotifierProvider(create: (context) => PostData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Functions App',
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
          DeliveryScreen.screenId: (context) => DeliveryScreen(),
          SignatureScreen.screenId: (context) => SignatureScreen(),
          BarcodeScreen.screenId: (context) => BarcodeScreen(),
          AddAddress.screenId: (context) => AddAddress(),
          RemainingPostScreen.screenId: (context) => RemainingPostScreen(),
          UndeliverablePostScreen.screenId: (context) =>
              UndeliverablePostScreen(),
          ScannedBarcode.screenId: (context) => ScannedBarcode(),
          DeliveredPostScreen.screenId: (context) => DeliveredPostScreen(),
        },
      ),
    );
  }
}
