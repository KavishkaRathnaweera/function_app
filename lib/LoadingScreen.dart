import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: true,
        child: Container(
          alignment: Alignment.center,
          color: Colors.black87,
        ),
      ),
    );
  }
}
