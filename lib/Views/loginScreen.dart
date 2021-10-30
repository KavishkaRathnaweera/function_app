import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Module/User.dart';
import 'package:function_app/Services/NetworkServices.dart';
import 'package:function_app/PostmanScreen.dart';
import 'package:function_app/DeliveryKeeper.dart';
import 'package:function_app/StateManagement/Data.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:function_app/Components/ReusableButton.dart';
import 'package:function_app/Constants.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static final String screenId = 'loginScreen';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String userEmail = '';
  late String userPassword = '';
  bool showSpinner = false;
  var message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Colors.red.shade900,
        ),
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/postOffice2.png'),
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
                    key: Key('heroWidget'),
                    tag: 'SL Post',
                    child: Container(
                      height: 50.0,
                      width: 50,
                      child: Image.asset('images/App_Icon.png'),
                    ),
                  ),
                ),
                Text(
                  'Sri Lanka Post',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      letterSpacing: 10.0,
                      fontWeight: FontWeight.w900),
                ),
                Flexible(
                  child: SizedBox(
                    height: 100.0,
                  ),
                ),
                TextField(
                  key: Key('textFieldEmail'),
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
                  key: Key('textFieldPassword'),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    userPassword = value;
                  },
                  decoration: kTextDecoration.copyWith(
                    hintText: 'Enter your password',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                ReusableButton(
                  buttonColor: Colors.red.shade900,
                  onPressed: () async {
                    if (validateEmailPassword(userEmail, userPassword)) {
                      handleUserLogin();
                    }
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

  bool validateEmailPassword(String email, String password) {
    if (email == null || email.isEmpty) {
      AlertBox.showMyDialog(context, 'Error!', 'Please Enter email', () {
        Navigator.of(context).pop();
      }, Colors.red[900]);
      return false;
    } else if (password == null || password.isEmpty) {
      AlertBox.showMyDialog(context, 'Error!', 'Please Enter password', () {
        Navigator.of(context).pop();
      }, Colors.red[900]);
      return false;
    } else {
      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      final regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        AlertBox.showMyDialog(context, 'Error!', 'Email is invalid', () {
          Navigator.of(context).pop();
        }, Colors.red[900]);
        return false;
      } else {
        return true;
      }
    }
  }

  handleUserLogin() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      final userDet =
          await NetworkService().getUserRole(userCredential.user!.uid);
      print(userDet['firstName']);
      Provider.of<DeliveryData>(context, listen: false).userDetails = AppUser(
        lastName: userDet['lastName'],
        firstName: userDet['firstName'],
        nic: userDet['NIC'],
      );
      if (userDet['role'] == 'postman') {
        final normalPostListDB = await NetworkService()
            .getServices(PostType.NormalPost, userCredential.user!.uid);
        final registeredPostListDB = await NetworkService()
            .getServices(PostType.RegisteredPost, userCredential.user!.uid);
        final packagePostListDB = await NetworkService()
            .getServices(PostType.Package, userCredential.user!.uid);

        final normalPostUndelListDB = await NetworkService()
            .getServicesUndeliverable(
                PostType.NormalPost, userCredential.user!.uid);
        final registeredPostUndelListDB = await NetworkService()
            .getServicesUndeliverable(
                PostType.RegisteredPost, userCredential.user!.uid);
        final packagePostUndelListDB = await NetworkService()
            .getServicesUndeliverable(
                PostType.Package, userCredential.user!.uid);

        final normalPostDeldListDB = await NetworkService()
            .getServicesDeivered(PostType.NormalPost, userCredential.user!.uid);
        final registeredPostDeldListDB = await NetworkService()
            .getServicesDeivered(
                PostType.RegisteredPost, userCredential.user!.uid);
        final packagePostDeldListDB = await NetworkService()
            .getServicesDeivered(PostType.Package, userCredential.user!.uid);

        // Provider.of<PostData>(context, listen: false).uid = userCredential.user!.uid;
        Provider.of<PostData>(context, listen: false)
            .setNormalPostList(normalPostListDB!);
        Provider.of<PostData>(context, listen: false)
            .setRegisteredPostList(registeredPostListDB!);
        Provider.of<PostData>(context, listen: false)
            .setPackagePostList(packagePostListDB!);

        Provider.of<PostData>(context, listen: false)
            .setNormalPostListUndelivereble(normalPostUndelListDB!);
        Provider.of<PostData>(context, listen: false)
            .setRegisteredPostListUndelivereble(registeredPostUndelListDB!);
        Provider.of<PostData>(context, listen: false)
            .setPackagePostListUndelivereble(packagePostUndelListDB!);

        Provider.of<PostData>(context, listen: false)
            .setNormalPostListDelivered(normalPostDeldListDB!);
        Provider.of<PostData>(context, listen: false)
            .setRegisteredPostListDelivered(registeredPostDeldListDB!);
        Provider.of<PostData>(context, listen: false)
            .setPackagePostDelivered(packagePostDeldListDB!);

        Navigator.pushNamed(context, PostmanScreen.screenId);
      } else if (userDet['role'] == 'deliveryLogKeeper') {
        Navigator.pushNamed(context, DeliveryScreen.screenId);
      } else {
        AlertBox.showMyDialog(
            context, 'Warning!', 'Permission Denied for this user', () {
          Navigator.of(context).pop();
        }, Colors.red[900]);
      }
    } on FirebaseAuthException catch (e) {
      print('aaaaaaaaaaa');
      if (e.code == 'user-not-found') {
        AlertBox.showMyDialog(context, 'Error!', 'User email cannot recognized',
            () {
          Navigator.of(context).pop();
        }, Colors.red[900]);
      } else if (e.code == 'wrong-password') {
        AlertBox.showMyDialog(context, 'Error!', 'Password is incorrect', () {
          Navigator.of(context).pop();
        }, Colors.red[900]);
      } else {
        AlertBox.showMyDialog(
            context, 'Error!', 'Please Check your network connection', () {
          Navigator.of(context).pop();
        }, Colors.red[900]);
      }
    } catch (e) {
      AlertBox.showMyDialog(context, 'Server Error!',
          'Please check your network connection or inform to Post Office : ${e} ',
          () {
        Navigator.of(context).pop();
      }, Colors.red[900]);
    }
    setState(() {
      showSpinner = false;
    });
  }

  getMessage() {
    return message;
  }
}
