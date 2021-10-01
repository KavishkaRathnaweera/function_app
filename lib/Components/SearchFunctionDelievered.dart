import 'package:flutter/material.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Views/SignatureView.dart';
import 'package:search_page/search_page.dart';
import 'ConstantFile.dart';
import 'package:provider/provider.dart';

import 'TextWrite.dart';

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
            trailing: TextButton(
              onPressed: () {
                if (widget.postType == PostType.NormalPost) {
                  Provider.of<PostData>(context, listen: false)
                      .removeNormalPostDelievered(post);
                } else if (widget.postType == PostType.RegisteredPost) {
                  Provider.of<PostData>(context, listen: false)
                      .removeRegisteredPostDelievered(post);
                } else if (widget.postType == PostType.Package) {
                  Provider.of<PostData>(context, listen: false)
                      .removePackagePostDelievered(post);
                }
              },
              child: Text('Undo to Pending'),
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
