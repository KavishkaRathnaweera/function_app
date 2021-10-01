import 'package:flutter/material.dart';
import 'package:function_app/Components/DrawerChild.dart';
import 'package:function_app/Module/PostItem.dart';
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
      body: Container(
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
                      title: Text(
                          '${postItem.getRecipientAddressNUmber}, ${postItem.getRecipientStreet1} road, ${postItem.getRecipientStreet2}, ${postItem.getRecipientCity}'),
                      subtitle: Text('${postItem.getRecipientName}'),
                      trailing: TextButton(
                        onPressed: () {
                          if (postType == PostType.NormalPost) {
                            postdata.removeNormalPostDelievered(postItem);
                          } else if (postType == PostType.RegisteredPost) {
                            postdata.removeRegisteredPostDelievered(postItem);
                          } else if (postType == PostType.Package) {
                            postdata.removePackagePostDelievered(postItem);
                          }
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
      floatingActionButton: SearchFunctionDelivered(
        postType: postType,
      ),
    );
  }
}
