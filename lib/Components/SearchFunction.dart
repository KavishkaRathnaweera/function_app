import 'package:flutter/material.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:search_page/search_page.dart';
import 'ConstantFile.dart';
import 'package:provider/provider.dart';

class SearchFunction extends StatelessWidget {
  SearchFunction({
    required this.postType,
  });
  final PostType postType;
  late List<PostItem> postItems;

  Widget build(BuildContext context) {
    if (postType == PostType.NormalPost) {
      postItems =
          Provider.of<PostData>(context, listen: false).getNormalPostList;
    }
    if (postType == PostType.RegisteredPost) {
      postItems =
          Provider.of<PostData>(context, listen: false).getRegisteredPostList;
    }
    if (postType == PostType.Package) {
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
            post.getRecipientStreet,
            post.getRecipientCity,
            post.getRecipientName,
          ],
          builder: (post) => ListTile(
            title: Text(
                '${post.getRecipientAddressNUmber}, ${post.getRecipientStreet}, ${post.getRecipientCity}'),
            subtitle: Text(post.getRecipientName),
            trailing: Checkbox(
              onChanged: (bool? value) {
                if (postType == PostType.NormalPost) {
                  Provider.of<PostData>(context, listen: false)
                      .removeNormalPost(post);
                }
                if (postType == PostType.RegisteredPost) {
                  Provider.of<PostData>(context, listen: false)
                      .removeRegisteredPost(post);
                }
                if (postType == PostType.Package) {
                  Provider.of<PostData>(context, listen: false)
                      .removepackagePost(post);
                }
                Navigator.pop(context);
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
