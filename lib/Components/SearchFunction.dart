import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Services/LocationServices.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Views/SignatureView.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_page/search_page.dart';
import 'AddressNameTile.dart';
import 'Alerts.dart';
import 'ConstantFile.dart';
import 'package:provider/provider.dart';
import 'package:function_app/Views/RemainingPostScreen.dart';

import 'SignatureTile.dart';
import 'TextWrite.dart';

class SearchFunction extends StatefulWidget {
  SearchFunction({
    required this.postType,
  });
  final PostType postType;

  @override
  _SearchFunctionState createState() => _SearchFunctionState();
}

class _SearchFunctionState extends State<SearchFunction> {
  late List<PostItem> postItems;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late bool locAvailable;

  void handleDatabaseResult(result, postItem, postType) {
    if (result == DatabaseResult.Success) {
      if (postType == PostType.NormalPost) {
        Provider.of<PostData>(context, listen: false)
            .removeNormalPost(postItem, PostAction.Success);
      } else if (postType == PostType.RegisteredPost) {
        Provider.of<PostData>(context, listen: false)
            .removeRegisteredPost(postItem, PostAction.Success);
      } else if (postType == PostType.Package) {
        Provider.of<PostData>(context, listen: false)
            .removePackagePost(postItem, PostAction.Success);
      }
      Navigator.popUntil(
          context, ModalRoute.withName('${RemainingPostScreen.screenId}'));
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

  void handleDBFailedDelivery(result, postItem, postType) {
    if (result == DatabaseResult.Success) {
      if (postType == PostType.NormalPost) {
        Provider.of<PostData>(context, listen: false)
            .removeNormalPost(postItem, PostAction.Fail);
      } else if (postType == PostType.RegisteredPost) {
        Provider.of<PostData>(context, listen: false)
            .removeRegisteredPost(postItem, PostAction.Fail);
      } else if (postType == PostType.Package) {
        Provider.of<PostData>(context, listen: false)
            .removePackagePost(postItem, PostAction.Fail);
      }
      Navigator.popUntil(
          context, ModalRoute.withName('${RemainingPostScreen.screenId}'));
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
    var locCoordinates = await LocationService.getCurrentPosition();
    if (locCoordinates == null) {
      locAvailable = false;
      locCoordinates = Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime(2),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
    } else {
      locAvailable = true;
    }
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
                AddressNameTile(postItem: postItem),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            DatabaseResult result =
                                await postItem.handleSuccessfulDelivery(
                                    signature,
                                    _auth.currentUser!.uid,
                                    locCoordinates);
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
                    SizedBox(width: 20.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          DatabaseResult result =
                              await postItem.handleFailedDelivery(
                                  _auth.currentUser!.uid, locCoordinates);
                          handleDBFailedDelivery(
                              result, postItem, PostType.NormalPost);
                        },
                        child:
                            Text('Failed', style: TextStyle(color: Colors.red)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                      ),
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
                AddressNameTile(postItem: postItem),
                SignatureTile(signature: signature),
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
                                    signature,
                                    _auth.currentUser!.uid,
                                    locCoordinates);
                            handleDatabaseResult(
                                result, postItem, PostType.RegisteredPost);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text('Delivered',
                              style: TextStyle(color: Colors.green))),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          DatabaseResult result =
                              await postItem.handleFailedDelivery(
                                  _auth.currentUser!.uid, locCoordinates);
                          handleDBFailedDelivery(
                              result, postItem, PostType.RegisteredPost);
                        },
                        child:
                            Text('Failed', style: TextStyle(color: Colors.red)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                      ),
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
                AddressNameTile(postItem: postItem),
                SignatureTile(signature: signature),
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
                                    signature,
                                    _auth.currentUser!.uid,
                                    locCoordinates);
                            handleDatabaseResult(
                                result, postItem, PostType.Package);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: Text('Delivered',
                              style: TextStyle(color: Colors.green))),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          DatabaseResult result =
                              await postItem.handleFailedDelivery(
                                  _auth.currentUser!.uid, locCoordinates);
                          handleDBFailedDelivery(
                              result, postItem, PostType.Package);
                        },
                        child:
                            Text('Failed', style: TextStyle(color: Colors.red)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                      ),
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
