import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Views/SignatureView.dart';
import 'package:search_page/search_page.dart';
import 'Alerts.dart';
import 'ConstantFile.dart';
import 'package:provider/provider.dart';
import 'package:function_app/Views/UndelivarablePostScreen.dart';

import 'TextWrite.dart';

class SearchFunctionUndelivered extends StatefulWidget {
  SearchFunctionUndelivered({
    required this.postType,
  });
  final PostType postType;

  @override
  _SearchFunctionUndelivered createState() => _SearchFunctionUndelivered();
}

class _SearchFunctionUndelivered extends State<SearchFunctionUndelivered> {
  late List<PostItem> postItems;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void handleDatabaseResult(result, postItem, postType) {
    if (result == DatabaseResult.Success) {
      if (postType == PostType.NormalPost) {
        Provider.of<PostData>(context, listen: false)
            .removeNormalPostUndeliverable(postItem);
      } else if (postType == PostType.RegisteredPost) {
        Provider.of<PostData>(context, listen: false)
            .removeRegisteredPostUndeliverable(postItem);
      } else if (postType == PostType.Package) {
        Provider.of<PostData>(context, listen: false)
            .removePackagePostUndeliverable(postItem);
      }
      Navigator.popUntil(
          context, ModalRoute.withName('${UndeliverablePostScreen.screenId}'));
      AlertBox.showMyDialog(context, 'Successful', 'Data Updated', () {
        Navigator.of(context).pop();
      }, Colors.green[900]);
    } else {
      AlertBox.showMyDialog(
          context, 'Failed', 'Check your Connection and Try again', () {
        Navigator.of(context).pop();
      }, Colors.red[900]);
    }
  }

  acceptButton(signature, type, PostItem postItem) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        //return Provider.value(value: myModel, child: BottomSheetCreate());
        if (type == PostType.NormalPost) {
          return Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWriteWidget('Address:', 20.0),
                SizedBox(height: 5.0),
                TextWriteWidget(
                    '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road,${postItem.getRecipientStreet2} ,${postItem.getRecipientCity}',
                    15.0),
                Divider(),
                SizedBox(height: 10.0),
                TextWriteWidget('Name:', 20.0),
                SizedBox(height: 5.0),
                TextWriteWidget('${postItem.getRecipientName}', 15.0),
                Divider(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            DatabaseResult result =
                                await postItem.handleSuccessfulDelivery(
                                    signature, _auth.currentUser!.uid);
                            handleDatabaseResult(
                                result, postItem, PostType.NormalPost);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text('Delivered',
                              style: TextStyle(color: Colors.green))),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (type == PostType.RegisteredPost) {
          return Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWriteWidget('Address:', 20.0),
                SizedBox(height: 5.0),
                TextWriteWidget(
                    '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road,${postItem.getRecipientStreet2} ,${postItem.getRecipientCity}',
                    15.0),
                Divider(),
                SizedBox(height: 10.0),
                TextWriteWidget('Name:', 20.0),
                SizedBox(height: 5.0),
                TextWriteWidget('${postItem.getRecipientName}', 15.0),
                Divider(),
                SizedBox(height: 20.0),
                TextWriteWidget('Signature:', 20.0),
                SizedBox(height: 5.0),
                Image.memory(
                  signature,
                  height: 50.0,
                ),
                Divider(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            DatabaseResult result =
                                await postItem.handleSuccessfulDelivery(
                                    signature, _auth.currentUser!.uid);
                            handleDatabaseResult(
                                result, postItem, PostType.NormalPost);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text('Delivered',
                              style: TextStyle(color: Colors.green))),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (type == PostType.Package) {
          return Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWriteWidget('Address:', 20.0),
                SizedBox(height: 5.0),
                TextWriteWidget(
                    '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road,${postItem.getRecipientStreet2} ,${postItem.getRecipientCity}, ',
                    15.0),
                Divider(),
                SizedBox(height: 10.0),
                TextWriteWidget('Name:', 20.0),
                SizedBox(height: 5.0),
                TextWriteWidget('${postItem.getRecipientName}', 15.0),
                Divider(),
                SizedBox(height: 20.0),
                TextWriteWidget('Signature:', 20.0),
                SizedBox(height: 5.0),
                Image.memory(
                  signature,
                  height: 50.0,
                ),
                Divider(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            DatabaseResult result =
                                await postItem.handleSuccessfulDelivery(
                                    signature, _auth.currentUser!.uid);
                            handleDatabaseResult(
                                result, postItem, PostType.NormalPost);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text('Delivered',
                              style: TextStyle(color: Colors.green))),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Column();
        }
      },
      //isScrollControlled: true,
    );
  }

  Widget build(BuildContext context) {
    if (widget.postType == PostType.NormalPost) {
      postItems =
          Provider.of<PostData>(context, listen: false).getNormalPostList;
    }
    if (widget.postType == PostType.RegisteredPost) {
      postItems =
          Provider.of<PostData>(context, listen: false).getRegisteredPostList;
    }
    if (widget.postType == PostType.Package) {
      postItems =
          Provider.of<PostData>(context, listen: false).getPackagePostList;
    }

    return FloatingActionButton(
      tooltip: 'Search Posts',
      onPressed: () => showSearch(
        context: context,
        delegate: SearchPage<PostItem>(
          onQueryUpdate: (s) => print(s),
          items: postItems,
          searchLabel: 'Search Posts',
          suggestion: Center(
            child: Text('Filter Posts by address or name'),
          ),
          failure: Center(
            child: Text('No post found :('),
          ),
          filter: (post) => [
            post.getRecipientAddressNUmber,
            post.getRecipientStreet1,
            post.getRecipientStreet2,
            post.getRecipientCity,
            post.getRecipientName,
          ],
          builder: (post) => ListTile(
            title: Text(
                '${post.getRecipientAddressNUmber}, ${post.getRecipientStreet1} road,${post.getRecipientStreet2} ,${post.getRecipientCity}'),
            subtitle: Text(post.getRecipientName),
            trailing: Checkbox(
              onChanged: (bool? value) async {
                var signature;
                if (widget.postType == PostType.NormalPost) {
                } else if (widget.postType == PostType.RegisteredPost) {
                  signature = await Navigator.pushNamed(
                      context, SignatureScreen.screenId);
                } else if (widget.postType == PostType.Package) {
                  signature = await Navigator.pushNamed(
                      context, SignatureScreen.screenId);
                }
                acceptButton(signature, widget.postType, post);
              },
              value: false,
            ),
          ),
        ),
      ),
      child: Icon(Icons.search),
    );
  }
}

/*
Navigator.of(context).popUntil((route) => route.isFirst);

 */
