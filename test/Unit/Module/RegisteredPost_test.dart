import 'package:function_app/Module/RegisteredPost.dart';
import 'package:test/test.dart';

void main() {
  compareObject(obj1, obj2) {
    return identical(obj1, obj2);
  }

  group('Package Post', () {
    test(' fromJson function :Package Post object should be created using json',
        () {
      Map<dynamic, dynamic> json = {
        "pid": "2021021555845",
        "cost": "100",
        "acceptedPostoffice": "/postOffice1",
        "destinationPostoffice": "/postOffice2",
        "recipientDetails": {
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
      };
      String docID = "f4252f435363wghdgdg3t3t53vdf";
      List<double> loc = [6.55555, 79.6666666];
      RegisteredPost obj1 = RegisteredPost.fromJson(json, docID, loc);
      RegisteredPost obj2 = RegisteredPost(
          pid: "2021021555845",
          cost: "100",
          loc: loc,
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
          destinationPO: "/postOffice2");
      bool result = compareObject(obj1, obj2);
      expect(obj1.toString(), obj2.toString());
    });
  });
}
