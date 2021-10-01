import 'package:flutter/material.dart';

class ReusableContainerCard extends StatelessWidget {
  // const ReusableContainerCard({
  //   Key key,
  // }) : super(key: key);
  ReusableContainerCard({required this.clr, required this.childCard});
  final Color clr;
  final Widget childCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: childCard,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: clr,
      ),
    );
  }
}
