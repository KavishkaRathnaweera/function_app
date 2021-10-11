import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Components/AddressNameTile.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Components/SignatureTile.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Services/LocationServices.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Components/SearchFuntionUndelivered.dart';
import 'package:function_app/Views/SignatureView.dart';

class UndeliverablePostScreen extends StatefulWidget {
  static final String screenId = 'UndeliverablePostScreen';

  @override
  _UndeliverablePostScreen createState() => _UndeliverablePostScreen();
}

class _UndeliverablePostScreen extends State<UndeliverablePostScreen> {
  late PostType postType;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late bool locAvailable;

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
      Navigator.pop(context);
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

  void acceptButtonUndeliverable(signature, type, PostItem postItem) async {
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

  @override
  Widget build(BuildContext context) {
    postType = ModalRoute.of(context)!.settings.arguments as PostType;
    String barName = '';
    if (postType == PostType.NormalPost) {
      barName = 'Normal';
    } else if (postType == PostType.RegisteredPost) {
      barName = 'Registered';
    } else if (postType == PostType.Package) {
      barName = 'Package';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$barName Undeliverable Post'),
      ),
      drawer: Drawer(
        child: DrawerChild(),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Consumer<PostData>(
          builder: (context, postdata, child) {
            List<PostItem> allPostList = [];
            if (postType == PostType.NormalPost) {
              allPostList = postdata.getNormalPostListUndelivereble;
            } else if (postType == PostType.RegisteredPost) {
              allPostList = postdata.getRegisteredPostListUndeliverable;
            } else if (postType == PostType.Package) {
              allPostList = postdata.getPackagePostListUndeleverable;
            }
            return ListView.builder(
              itemCount: allPostList.length,
              itemBuilder: (context, index) {
                final PostItem postItem = allPostList[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                          '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road, ${postItem.getRecipientStreet2 != null ? postItem.getRecipientStreet2 + 'road' : ''}, ${postItem.getRecipientCity}'),
                      subtitle: Text('${postItem.getRecipientName}'),
                      trailing: Checkbox(
                        onChanged: (bool? value) async {
                          var signature;
                          if (postType == PostType.NormalPost) {
                            //postdata.removeNormalPost(postItem);
                          } else if (postType == PostType.RegisteredPost) {
                            // postdata.removeRegisteredPost(postItem);
                            signature = await Navigator.pushNamed(
                                context, SignatureScreen.screenId);
                          } else if (postType == PostType.Package) {
                            //postdata.removepackagePost(postItem);
                            signature = await Navigator.pushNamed(
                                context, SignatureScreen.screenId);
                          }
                          acceptButtonUndeliverable(
                              signature, postType, postItem);
                        },
                        value: false,
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: SearchFunctionUndelivered(
        postType: postType,
      ),
    );
  }
}
