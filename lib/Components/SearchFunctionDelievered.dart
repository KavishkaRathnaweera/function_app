import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Views/DeliveredPostScreen.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:search_page/search_page.dart';
import 'Alerts.dart';
import 'ConstantFile.dart';
import 'package:provider/provider.dart';

class SearchFunctionDelivered extends StatefulWidget {
  SearchFunctionDelivered({
    required this.postType,
  });
  final PostType postType;

  @override
  _SearchFunctionDelivered createState() => _SearchFunctionDelivered();
}

class _SearchFunctionDelivered extends State<SearchFunctionDelivered> {
  late List<PostItem> postItems;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late bool locAvailable;
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
      Navigator.popUntil(
          context, ModalRoute.withName('${DeliveredPostScreen.screenId}'));
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

  Widget build(BuildContext context) {
    if (widget.postType == PostType.NormalPost) {
      postItems = Provider.of<PostData>(context, listen: false)
          .getNormalPostListDelievered;
    }
    if (widget.postType == PostType.RegisteredPost) {
      postItems = Provider.of<PostData>(context, listen: false)
          .getRegisteredPostListDelievered;
    }
    if (widget.postType == PostType.Package) {
      postItems = Provider.of<PostData>(context, listen: false)
          .getPackagePostListDelivered;
    }

    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        color: Colors.red.shade900,
      ),
      inAsyncCall: showSpinner,
      child: FloatingActionButton(
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
                  '${post.getRecipientAddressNUmber}, ${post.getRecipientStreet1} road, ${post.getRecipientStreet2}, ${post.getRecipientCity}'),
              subtitle: Text('${post.getRecipientName}'),
              trailing: TextButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  DatabaseResult result =
                      await post.restorePost(_auth.currentUser!.uid);
                  setState(() {
                    showSpinner = false;
                  });
                  handleDatabaseResult(result, post, widget.postType);
                },
                child: Text('Restore'),
              ),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}

/*
Navigator.of(context).popUntil((route) => route.isFirst);

 */
