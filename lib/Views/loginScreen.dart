import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/DeliveryKeeper.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Constants.dart';
import 'package:function_app/Components/Alerts.dart';

class LoginScreen extends StatefulWidget {
  static final String screenId = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String userEmail;
  late String userPassword;
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
                      child: Image.asset('images/App_Icon.png'),
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
                    userEmail = value;
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
                    userPassword = value;
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
                    try {
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                        email: userEmail,
                        password: userPassword,
                      );
                      if (userCredential.user!.email == 'postman@gmail.com') {
                        Navigator.pushNamed(context, PostmanScreen.screenId);
                      } else if (userCredential.user!.email ==
                          'deliver@gmail.com') {
                        Navigator.pushNamed(context, DeliveryScreen.screenId);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        AlertBox.showMyDialog(
                            context, 'Error!', 'User email is not valid', () {
                          Navigator.of(context).pop();
                        });
                      } else if (e.code == 'wrong-password') {
                        AlertBox.showMyDialog(
                            context, 'Error!', 'Password is incorrect', () {
                          Navigator.of(context).pop();
                        });
                      }
                    }

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
