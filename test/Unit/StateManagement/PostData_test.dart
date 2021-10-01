import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:test/test.dart';
import 'package:function_app/StateManagement/PostData.dart';

void main() {
  List<PostItem> npList = [
    NormalPost(
        pid: "2021021555845",
        cost: "100",
        loc: [],
        recName: "kevin peter",
        recAdNum: "158/8",
        recStreet1: "2nd",
        recStreet2: "3rd",
        recCity: "New york",
        ispending: true,
        iscannotdel: false,
        acceptedPO: "/postOffice1",
        docID: "f4252f435363wghdgdg3t3t53vdf",
        destinationPO: "/postOffice2"),
    NormalPost(
        pid: "202134333333333334343",
        cost: "100",
        loc: [],
        recName: "Dwayn johnson",
        recAdNum: "158/8",
        recStreet1: "2nd",
        recStreet2: "3rd",
        recCity: "Mumbai",
        ispending: true,
        iscannotdel: false,
        acceptedPO: "/postOffice1",
        docID: "f4252f435363wghdgdg3t3t53vdf",
        destinationPO: "/postOffice2"),
  ];

  List<PostItem> rpList = [
    RegisteredPost(
        pid: "2021021555845",
        cost: "100",
        loc: [],
        recName: "kevin peter",
        recAdNum: "158/8",
        recStreet1: "2nd",
        recStreet2: "3rd",
        recCity: "New york",
        ispending: true,
        iscannotdel: false,
        acceptedPO: "/postOffice1",
        docID: "f4252f4353633f3f4g6h3t3t53vdf",
        senderEmail: "kevin@gmail.com",
        senderName: "kevin peter",
        senderStreet1: "2nd",
        senderStreet2: "3rd",
        senderAddressNUmber: "158/8",
        senderCity: "New york",
        destinationPO: "/postOffice2"),
    RegisteredPost(
        pid: "2021024364845",
        cost: "100",
        loc: [],
        recName: "Peter Robinson",
        recAdNum: "158/8",
        recStreet1: "2nd",
        recStreet2: "3rd",
        recCity: "London",
        ispending: true,
        iscannotdel: false,
        acceptedPO: "/postOffice1",
        docID: "f4254h74hf7h47f4h733t3t53vdf",
        senderEmail: "peter@gmail.com",
        senderName: "kevin peter",
        senderStreet1: "2nd",
        senderStreet2: "3rd",
        senderAddressNUmber: "158/8",
        senderCity: "New york",
        destinationPO: "/postOffice2")
  ];

  List<PostItem> ppList = [
    PackagePost(
        pid: "20222223546464845",
        cost: "100",
        loc: [],
        recName: "kevin peter",
        recAdNum: "158/8",
        recStreet1: "2nd",
        recStreet2: "3rd",
        recCity: "New york",
        ispending: true,
        iscannotdel: false,
        acceptedPO: "/postOffice1",
        docID: "f4254h74hf7h47f4h733t3t53vdf",
        senderEmail: "kevin@gmail.com",
        senderName: "kevin peter",
        senderStreet1: "2nd",
        senderStreet2: "3rd",
        senderAddressNUmber: "158/8",
        senderCity: "New york",
        destinationPO: "/postOffice2",
        receiverEmail: 'kevin@gmail.com',
        weight: "100"),
    PackagePost(
        pid: "20278463532545",
        cost: "100",
        loc: [],
        recName: "kevin peter",
        recAdNum: "158/8",
        recStreet1: "2nd",
        recStreet2: "3rd",
        recCity: "New york",
        ispending: true,
        iscannotdel: false,
        acceptedPO: "/postOffice1",
        docID: "f4254h74hf7h47f4h733t3t53vdf",
        senderEmail: "kevin@gmail.com",
        senderName: "kevin peter",
        senderStreet1: "2nd",
        senderStreet2: "3rd",
        senderAddressNUmber: "158/8",
        senderCity: "New york",
        destinationPO: "/postOffice2",
        receiverEmail: 'kevin@gmail.com',
        weight: "100")
  ];
  compareObject(obj1, obj2) {
    return identical(obj1, obj2);
  }

  group('State Management : NormalPost list', () {
    test(
        ' getNormalpost() and setNormalPost() : Add Normal post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostList(npList);
      expect(postDataObj.getNormalPostList, npList);
    });
    test(
        ' getNormalpost() and setNormalPost() : Must return empty list when instanse type is not Normal post',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostList(rpList);
      expect(postDataObj.getNormalPostList, []);
    });
    test(
        ' getRegisteredPost() and setRegisteredPost() : Add Registered post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setRegisteredPostList(rpList);
      expect(postDataObj.getRegisteredPostList, rpList);
    });
    test(
        ' getRegisteredPost() and setRegisteredPost() : Must return empty list when instanse type is not Registered post',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostList(ppList);
      expect(postDataObj.getNormalPostList, []);
    });
    test(
        ' getPackagePost() and setPackagePost() : Add Package post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setPackagePostList(ppList);
      expect(postDataObj.getPackagePostList, ppList);
    });
    test(
        ' getPackagePost() and setPackagePost() : Must return empty list when instanse type is not Package post',
        () {
      final postDataObj = PostData();
      postDataObj.setPackagePostList(npList);
      expect(postDataObj.getPackagePostList, []);
    });

    test(
        ' getNormalPostListDelievered() and setNormalPostListDelievered() : Add Normal post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostListDelivered(npList);
      expect(postDataObj.getNormalPostListDelievered, npList);
    });
    test(
        ' getNormalPostListDelievered() and setNormalPostListDelievered() : Must return empty list when instanse type is not Normal post',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostListDelivered(rpList);
      expect(postDataObj.getNormalPostListDelievered, []);
    });
    test(
        ' getRegisteredPostListDelievered() and setRegisteredPostListDelievered() : Add Registered post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setRegisteredPostListDelivered(rpList);
      expect(postDataObj.getRegisteredPostListDelievered, rpList);
    });
    test(
        ' getRegisteredPostListDelievered() and setRegisteredPostListDelievered() : Must return empty list when instanse type is not Registered post',
        () {
      final postDataObj = PostData();
      postDataObj.setRegisteredPostListDelivered(ppList);
      expect(postDataObj.getRegisteredPostListDelievered, []);
    });
    test(
        ' getPackagePostListDelivered() and setPackagePostListDelivered() : Add Package post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setPackagePostDelivered(ppList);
      expect(postDataObj.getPackagePostListDelivered, ppList);
    });
    test(
        ' getPackagePostListDelivered() and setPackagePostListDelivered() : Must return empty list when instanse type is not Package post',
        () {
      final postDataObj = PostData();
      postDataObj.setPackagePostDelivered(npList);
      expect(postDataObj.getPackagePostListDelivered, []);
    });

    test(
        ' getNormalPostListUndelivereble() and setNormalPostListUndelivereble() : Add Normal post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostListUndelivereble(npList);
      expect(postDataObj.getNormalPostListUndelivereble, npList);
    });
    test(
        ' getNormalPostListUndelivereble() and setNormalPostListUndelivereble() : Must return empty list when instanse type is not Normal post',
        () {
      final postDataObj = PostData();
      postDataObj.setNormalPostListUndelivereble(rpList);
      expect(postDataObj.getNormalPostListUndelivereble, []);
    });
    test(
        ' getRegisteredPostListUndeliverable() and setRegisteredPostListUndeliverable() : Add Registered post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setRegisteredPostListUndelivereble(rpList);
      expect(postDataObj.getRegisteredPostListUndeliverable, rpList);
    });
    test(
        ' getRegisteredPostListUndeliverable() and setRegisteredPostListUndeliverable() : Must return empty list when instanse type is not Registered post',
        () {
      final postDataObj = PostData();
      postDataObj.setRegisteredPostListUndelivereble(ppList);
      expect(postDataObj.getRegisteredPostListUndeliverable, []);
    });
    test(
        ' getPackagePostListUndeleverable() and setPackagePostListUndeleverable() : Add Package post list and retrieve',
        () {
      final postDataObj = PostData();
      postDataObj.setPackagePostListUndelivereble(ppList);
      expect(postDataObj.getPackagePostListUndeleverable, ppList);
    });
    test(
        ' getPackagePostListUndeleverable() and setPackagePostListUndeleverable() : Must return empty list when instanse type is not Package post',
        () {
      final postDataObj = PostData();
      postDataObj.setPackagePostListUndelivereble(npList);
      expect(postDataObj.getPackagePostListUndeleverable, []);
    });
  });
}
