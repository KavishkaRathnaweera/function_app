import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:function_app/Constants/ReusableButton.dart';
import 'package:function_app/Constants.dart';

class LoginScreen extends StatefulWidget {
  static final String screenId = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        //inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'SL Post',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/national.png'),
                    ),
                  ),
                ),
                Text(
                  'Sri Lanka Post',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                Flexible(
                  child: SizedBox(
                    height: 100.0,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextDecoration.copyWith(
                    hintText: 'Enter your password.',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                ReusableButton(
                  buttonColor: Colors.red.shade900,
                  onPressed: () async {
                    Navigator.pushNamed(context, PostmanScreen.screenId);
                    // setState(() {
                    //   showSpinner = true;
                    // });
                    // try {
                    //   final user = await _auth.signInWithEmailAndPassword(
                    //       email: email, password: password);
                    //   if (user != null) {
                    //     Navigator.pushNamed(context, ChatScreen.screenId);
                    //   }
                    //   setState(() {
                    //     showSpinner = false;
                    //   });
                    // } catch (e) {
                    //   print(e);
                    // }
                  },
                  label: 'Log In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('images/Cover.jpg'),
// fit: BoxFit.fill,
// ),
// ),
