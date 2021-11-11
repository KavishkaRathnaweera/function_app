import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Components/AddressNameTile.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Components/SignatureTile.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Services/LocationServices.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Components/SearchFunction.dart';
import 'package:function_app/Views/SignatureView.dart';

class RemainingPostScreen extends StatefulWidget {
  static final String screenId = 'RemainingPostScreen';

  @override
  _RemainingPostScreenState createState() => _RemainingPostScreenState();
}

class _RemainingPostScreenState extends State<RemainingPostScreen> {
  late PostType postType;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Position initLocation;
  late bool locAvailable;
  bool showSpinner = false;

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
      // Navigator.pop(context);
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
      // Navigator.pop(context);
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

  void acceptButton(signature, type, PostItem postItem) async {
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
          return ListView(key: Key('bottomSheetList'), children: [
            Container(
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
                            key: Key('deliveredTextButton'),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              Navigator.of(context).pop();
                              DatabaseResult result =
                                  await postItem.handleSuccessfulDelivery(
                                      signature,
                                      _auth.currentUser!.uid,
                                      locCoordinates);
                              setState(() {
                                showSpinner = false;
                              });
                              handleDatabaseResult(
                                  result, postItem, PostType.NormalPost);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text('Delivered',
                                style: TextStyle(color: Colors.green))),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextButton(
                          key: Key('failedTextButton'),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            Navigator.of(context).pop();
                            DatabaseResult result =
                                await postItem.handleFailedDelivery(
                                    _auth.currentUser!.uid, locCoordinates);
                            setState(() {
                              showSpinner = false;
                            });
                            handleDBFailedDelivery(
                                result, postItem, PostType.NormalPost);
                          },
                          child: Text('Failed',
                              style: TextStyle(color: Colors.red)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  LocationTile(locAvailable: locAvailable),
                ],
              ),
            ),
          ]);
        } else if (type == PostType.RegisteredPost) {
          return ListView(key: Key('bottomSheetList'), children: [
            Container(
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
                            key: Key('deliveredTextButton'),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              Navigator.of(context).pop();
                              DatabaseResult result =
                                  await postItem.handleSuccessfulDelivery(
                                      signature,
                                      _auth.currentUser!.uid,
                                      locCoordinates);
                              setState(() {
                                showSpinner = false;
                              });
                              handleDatabaseResult(
                                  result, postItem, PostType.RegisteredPost);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text('Delivered',
                                style: TextStyle(color: Colors.green))),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextButton(
                          key: Key('failedTextButton'),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            Navigator.of(context).pop();
                            DatabaseResult result =
                                await postItem.handleFailedDelivery(
                                    _auth.currentUser!.uid, locCoordinates);
                            setState(() {
                              showSpinner = false;
                            });
                            handleDBFailedDelivery(
                                result, postItem, PostType.RegisteredPost);
                          },
                          child: Text('Failed',
                              style: TextStyle(color: Colors.red)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  LocationTile(locAvailable: locAvailable),
                ],
              ),
            ),
          ]);
        } else if (type == PostType.Package) {
          return ListView(key: Key('bottomSheetList'), children: [
            Container(
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
                            key: Key('deliveredTextButton'),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              Navigator.of(context).pop();
                              DatabaseResult result =
                                  await postItem.handleSuccessfulDelivery(
                                      signature,
                                      _auth.currentUser!.uid,
                                      locCoordinates);
                              setState(() {
                                showSpinner = false;
                              });
                              handleDatabaseResult(
                                  result, postItem, PostType.Package);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text('Delivered',
                                style: TextStyle(color: Colors.green))),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextButton(
                          key: Key('failedTextButton'),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            Navigator.of(context).pop();
                            DatabaseResult result =
                                await postItem.handleFailedDelivery(
                                    _auth.currentUser!.uid, locCoordinates);
                            setState(() {
                              showSpinner = false;
                            });
                            handleDBFailedDelivery(
                                result, postItem, PostType.Package);
                          },
                          child: Text('Failed',
                              style: TextStyle(color: Colors.red)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  LocationTile(locAvailable: locAvailable),
                ],
              ),
            ),
          ]);
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
        title: Text('$barName Pending Post'),
      ),
      drawer: Drawer(
        child: DrawerChild(),
      ),
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Colors.red.shade900,
        ),
        inAsyncCall: showSpinner,
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Consumer<PostData>(
            builder: (context, postdata, child) {
              List<PostItem> allPostList = [];
              if (postType == PostType.NormalPost) {
                allPostList = postdata.getNormalPostList;
              } else if (postType == PostType.RegisteredPost) {
                allPostList = postdata.getRegisteredPostList;
              } else if (postType == PostType.Package) {
                allPostList = postdata.getPackagePostList;
              }
              return ListView.builder(
                itemCount: allPostList.length,
                itemBuilder: (context, index) {
                  final PostItem postItem = allPostList[index];
                  print(index);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                            '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road, ${postItem.getRecipientStreet2} ${postItem.getRecipientCity}'),
                        subtitle: Text('${postItem.getRecipientName}'),
                        trailing: Checkbox(
                          key: Key('$index'),
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
                            if (signature != null ||
                                postType == PostType.NormalPost) {
                              acceptButton(signature, postType, postItem);
                            }
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
      ),
      floatingActionButton: SearchFunction(
        postType: postType,
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  const LocationTile({
    required this.locAvailable,
  });
  final bool locAvailable;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: (locAvailable)
          ? Text('Location of this address will added to the system',
              style: TextStyle(color: Colors.green[900]))
          : Text('Location Disabled. Address adding function will not work',
              style: TextStyle(color: Colors.red[900])),
      leading: (locAvailable)
          ? Icon(
              Icons.check,
              color: Colors.green,
            )
          : Icon(
              Icons.error,
              color: Colors.red[900],
            ),
    );
  }
}
