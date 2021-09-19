import 'package:flutter/material.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:provider/provider.dart';
import 'package:function_app/StateManagement/PostData.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Components/SearchFunction.dart';

class NormalPostScreen extends StatelessWidget {
  static final String screenId = 'NormalPostScreen';
  late PostType postType;
  @override
  Widget build(BuildContext context) {
    postType = ModalRoute.of(context)!.settings.arguments as PostType;
    print(postType);
    return Scaffold(
      appBar: AppBar(
        title: Text('Normal Post'),
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
                return ListTile(
                  title: Text(
                      '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet}, ${postItem.getRecipientCity}'),
                  subtitle: Text('${postItem.getRecipientName}'),
                  trailing: Checkbox(
                    onChanged: (bool? value) {
                      if (postType == PostType.NormalPost) {
                        postdata.removeNormalPost(postItem);
                      } else if (postType == PostType.RegisteredPost) {
                        postdata.removeRegisteredPost(postItem);
                      } else if (postType == PostType.Package) {
                        postdata.removepackagePost(postItem);
                      }

                      //setState(() {});
                    },
                    value: false,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: SearchFunction(
        postType: PostType.NormalPost,
      ),
    );
  }
}
