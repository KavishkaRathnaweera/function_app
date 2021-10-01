import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:test/test.dart';

void main() {
  compareObject(obj1, obj2) {
    return identical(obj1, obj2);
  }

  group('Registered Post', () {
    test(
        ' fromJson function :Registered Post object should be created using json',
        () {
      Map<dynamic, dynamic> json = {
        "pid": "2021021555845",
        "cost": "100",
        "acceptedPostoffice": "/postOffice1",
        "destinationPostoffice": "/postOffice2",
        "recipientDetails": {
          "recipientEmail": "kevin@gmail.com",
          "recipientName": "kevin peter",
          "recipientAddressNo": "158/8",
          "recipientStreet1": "2nd",
          "recipientStreet2": "3rd",
          "recipientCity": "New york"
        },
        "senderDetails": {
          "senderEmail": "kevin@gmail.com",
          "senderName": "kevin peter",
          "senderAddressNo": "158/8",
          "senderStreet1": "2nd",
          "senderStreet2": "3rd",
          "senderCity": "New york",
        },
        "weight": "100"
      };
      String docID = "f4252f435363wghdgdg3t3t53vdf";
      PackagePost obj1 = PackagePost.fromJson(json, docID);
      PackagePost obj2 = PackagePost(
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
          docID: docID,
          senderEmail: "kevin@gmail.com",
          senderName: "kevin peter",
          senderStreet1: "2nd",
          senderStreet2: "3rd",
          senderAddressNUmber: "158/8",
          senderCity: "New york",
          destinationPO: "/postOffice2",
          receiverEmail: 'kevin@gmail.com',
          weight: "100");
      expect(obj1.toString(), obj2.toString());
    });
  });
}
