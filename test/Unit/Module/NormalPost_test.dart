import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/test.dart';
import 'package:function_app/Module/NormalPost.dart';

void main() {
  compareObject(obj1, obj2) {
    return identical(obj1, obj2);
  }

  group('Normal Post', () {
    test(' fromJson function :Normal Post object should be created using json',
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
          "recipientStreet2": "4nd",
          "recipientCity": "New york"
        },
        "senderDetails": {
          "senderName": "kevin peter",
          "senderAddressNo": "158/8",
          "senderStreet1": "2nd Street",
          "senderStreet2": "",
          "senderCity": "New york"
        },
      };
      String docID = "f4252f435363wghdgdg3t3t53vdf";
      NormalPost obj1 = NormalPost.fromJson(json, docID);
      NormalPost obj2 = NormalPost(
          pid: "2021021555845",
          cost: "100",
          loc: [],
          recName: "kevin peter",
          recAdNum: "158/8",
          recStreet1: "2nd",
          recStreet2: "4nd",
          recCity: "New york",
          ispending: true,
          iscannotdel: false,
          acceptedPO: "/postOffice1",
          docID: docID,
          destinationPO: "/postOffice2");
      bool result = compareObject(obj1, obj2);
      expect(obj1.toString(), obj2.toString());
    });
  });
}
