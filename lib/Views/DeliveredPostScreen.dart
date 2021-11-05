import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Components/Alerts.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Components/SearchFunctionDelievered.dart';

class DeliveredPostScreen extends StatefulWidget {
  static final String screenId = 'DeliveredPostScreen';

  @override
  _DeliveredPostScreen createState() => _DeliveredPostScreen();
}

class _DeliveredPostScreen extends State<DeliveredPostScreen> {
  late PostType postType;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  void handleDatabaseResult(result, postItem, postType) {
    if (result == DatabaseResult.Success) {
      if (postType == PostType.NormalPost) {
        Provider.of<PostData>(context, listen: false)
            .removeNormalPostDelievered(postItem);
      } else if (postType == PostType.RegisteredPost) {
        Provider.of<PostData>(context, listen: false)
            .removeRegisteredPostDelievered(postItem);
      } else if (postType == PostType.Package) {
        Provider.of<PostData>(context, listen: false)
            .removePackagePostDelievered(postItem);
      }
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
        title: Text('$barName Delivered Post'),
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
                allPostList = postdata.getNormalPostListDelievered;
              } else if (postType == PostType.RegisteredPost) {
                allPostList = postdata.getRegisteredPostListDelievered;
              } else if (postType == PostType.Package) {
                allPostList = postdata.getPackagePostListDelivered;
              }
              return ListView.builder(
                itemCount: allPostList.length,
                itemBuilder: (context, index) {
                  final PostItem postItem = allPostList[index];
                  return Column(
                    children: [
                      ListTile(
                        key: Key('$index'),
                        title: Text(
                            '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road, ${postItem.getRecipientStreet2}, ${postItem.getRecipientCity}'),
                        subtitle: Text('${postItem.getRecipientName}'),
                        trailing: TextButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            DatabaseResult result = await postItem
                                .restorePost(_auth.currentUser!.uid);
                            setState(() {
                              showSpinner = false;
                            });
                            handleDatabaseResult(result, postItem, postType);
                          },
                          child: Text('Restore'),
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
      floatingActionButton: SearchFunctionDelivered(
        postType: postType,
      ),
    );
  }
}
