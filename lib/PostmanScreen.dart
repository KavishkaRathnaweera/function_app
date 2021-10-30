import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:function_app/Components/TextWrite.dart';
import 'package:provider/provider.dart';

import 'Components/ContainerCard.dart';
import 'Components/DrawerChild.dart';
import 'Components/IconCard.dart';
import 'Constants.dart';
import 'StateManagement/PostData.dart';
import 'Views/loginScreen.dart';

class PostmanScreen extends StatefulWidget {
  static final String screenId = 'postmanScreen';

  @override
  PostmanScreenState createState() => PostmanScreenState();
}

class PostmanScreenState extends State<PostmanScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString()
          .substring(0, 10);

  @override
  void initState() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      Navigator.popUntil(
          context, ModalRoute.withName('${LoginScreen.screenId}'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('postmanScafKey'),
        appBar: AppBar(
          title: Text('Postman'),
        ),
        drawer: Drawer(
          child: DrawerChild(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: 0.0, left: 10.0, right: 10.0, top: 10.0),
                color: kinactiveCardColor,
                child: Center(child: TextWriteWidget('${date}', 20.0)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                color: kinactiveCardColor,
                child: Column(
                  children: [
                    TextWriteWidget('Normal Post Details', 18.0),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableContainerCard(
                              childCard: reusableIconText(
                                name: 'Remaining',
                                number: Provider.of<PostData>(context)
                                    .getNormalPostList
                                    .length,
                                color: Colors.blueGrey,
                              ),
                              clr: kactiveCardColor,
                            ),
                          ),
                          Expanded(
                            child: ReusableContainerCard(
                              clr: kactiveCardColor,
                              // : kinactiveCardColor,
                              childCard: reusableIconText(
                                name: 'Delivered',
                                number: Provider.of<PostData>(context)
                                    .getNormalPostListDelievered
                                    .length,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableContainerCard(
                              clr: kactiveCardColor,
                              // : kinactiveCardColor,
                              childCard: reusableIconText(
                                name: 'Rejected',
                                number: Provider.of<PostData>(context)
                                    .getNormalPostListUndelivereble
                                    .length,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: 20.0, left: 10.0, right: 10.0, top: 20.0),
                color: kinactiveCardColor,
                child: Column(
                  children: [
                    TextWriteWidget('Registered Post Details', 18.0),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableContainerCard(
                              childCard: reusableIconText(
                                name: 'Remaining',
                                number: Provider.of<PostData>(context)
                                    .getRegisteredPostList
                                    .length,
                                color: Colors.blueGrey,
                              ),
                              clr: kactiveCardColor,
                            ),
                          ),
                          Expanded(
                            child: ReusableContainerCard(
                              clr: kactiveCardColor,
                              // : kinactiveCardColor,
                              childCard: reusableIconText(
                                name: 'Delivered',
                                number: Provider.of<PostData>(context)
                                    .getRegisteredPostListDelievered
                                    .length,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableContainerCard(
                              clr: kactiveCardColor,
                              // : kinactiveCardColor,
                              childCard: reusableIconText(
                                name: 'Rejected',
                                number: Provider.of<PostData>(context)
                                    .getRegisteredPostListUndeliverable
                                    .length,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: 30.0, left: 10.0, right: 10.0, top: 10.0),
                color: kinactiveCardColor,
                child: Column(
                  children: [
                    TextWriteWidget('Package Post Details', 18.0),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableContainerCard(
                              childCard: reusableIconText(
                                name: 'Remaining',
                                number: Provider.of<PostData>(context)
                                    .getPackagePostList
                                    .length,
                                color: Colors.blueGrey,
                              ),
                              clr: kactiveCardColor,
                            ),
                          ),
                          Expanded(
                            child: ReusableContainerCard(
                              clr: kactiveCardColor,
                              // : kinactiveCardColor,
                              childCard: reusableIconText(
                                name: 'Delivered',
                                number: Provider.of<PostData>(context)
                                    .getPackagePostListDelivered
                                    .length,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableContainerCard(
                              clr: kactiveCardColor,
                              // : kinactiveCardColor,
                              childCard: reusableIconText(
                                name: 'Rejected',
                                number: Provider.of<PostData>(context)
                                    .getPackagePostListUndeleverable
                                    .length,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
