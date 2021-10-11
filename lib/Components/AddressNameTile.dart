import 'package:flutter/material.dart';

import 'TextWrite.dart';

class AddressNameTile extends StatelessWidget {
  AddressNameTile({this.postItem});
  final postItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: TextWriteWidget('Address of receiver', 20.0),
          subtitle: TextWriteWidget(
              '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road, ${postItem.getRecipientStreet2}, ${postItem.getRecipientCity}',
              15.0),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.person),
          title: TextWriteWidget('Name of receiver', 20.0),
          subtitle: TextWriteWidget('${postItem.getRecipientName}', 15.0),
        ),
        Divider(),
      ],
    );
  }
}
