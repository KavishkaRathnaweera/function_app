import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Services/NetworkServices.dart';

class NormalPost extends PostItem {
  NormalPost(
      {required String pid,
      required String cost,
      required List<double> loc,
      required String recName,
      required String recAdNum,
      required String recStreet1,
      required String recStreet2,
      required String recCity,
      required bool ispending,
      required bool iscannotdel,
      required var acceptedPO,
      required String docID,
      required var destinationPO})
      : super(
            cost: cost,
            pid: pid,
            location: loc,
            recipientName: recName,
            recipientAddressNUmber: recAdNum,
            recipientStreet1: recStreet1,
            recipientStreet2: recStreet2,
            recipientCity: recCity,
            isPending: ispending,
            isCannotDelivered: iscannotdel,
            acceptedPO: acceptedPO,
            docID: docID,
            destinationPO: destinationPO);

  @override
  Future<DatabaseResult> handleFailedDelivery(uid, locPosition) async {
    if (location[0] == 0.0) {
      setLocation([locPosition.latitude, locPosition.longitude]);
      return await NetworkService().PostFailed(uid, docID, this, true);
    } else {
      return await NetworkService().PostFailed(uid, docID, this, false);
    }
  }

  @override
  Future<DatabaseResult> handleSuccessfulDelivery(
      signature, uid, locPosition) async {
    if (location[0] == 0.0) {
      setLocation([locPosition.latitude, locPosition.longitude]);
      return await NetworkService().PostDelivery(uid, docID, this, true);
    } else {
      return await NetworkService().PostDelivery(uid, docID, this, false);
    }
  }

  Future<DatabaseResult> restorePost(uid) async {
    return await NetworkService().PostRestore(uid, docID, this);
  }

  factory NormalPost.fromJson(
          Map<dynamic, dynamic> json, String docID, locDetails) =>
      NormalPost(
        pid: json["pid"],
        loc: locDetails,
        docID: docID,
        cost: json["cost"].toString(),
        acceptedPO: json["acceptedPostoffice"],
        destinationPO: json["destinationPostoffice"],
        recName: json["recipientDetails"]["recipientName"],
        recAdNum: json["recipientDetails"]["recipientAddressNo"],
        recStreet1: json["recipientDetails"]["recipientStreet1"],
        recStreet2: json["recipientDetails"]["recipientStreet2"],
        recCity: json["recipientDetails"]["recipientCity"],
        ispending: true,
        iscannotdel: false,
      );

  Map<String, dynamic> toJson(uid, day) => {
        "pid": pid,
        "acceptedPostoffice": acceptedPO,
        "destinationPostoffice": destinationPO,
        "recipientDetails": {
          "recipientAddressNo": recipientAddressNUmber,
          "recipientStreet1": recipientStreet1,
          "recipientStreet2": recipientStreet2,
          "recipientCity": recipientCity,
          "recipientName": recipientName
        },
        "type": "NormalPost",
        "histories": [
          {
            "action": "Delivered",
            "employee": FirebaseFirestore.instance.collection('Users').doc(uid),
            "date": day,
          }
        ],
        "state": "Delivered",
        "senderDetails": {},
        "cost": cost,
        "timestamp": Timestamp.now(),
      };

  Map<String, dynamic> toJsonPending(uid) => {
        "pid": pid,
        "acceptedPostoffice": acceptedPO,
        "destinationPostoffice": destinationPO,
        "recipientDetails": {
          "recipientAddressNo": recipientAddressNUmber,
          "recipientStreet1": recipientStreet1,
          "recipientStreet2": recipientStreet2,
          "recipientCity": recipientCity,
          "recipientName": recipientName
        },
        "type": "NormalPost",
        "histories": [
          {
            "action": "Assigned",
            "employee": FirebaseFirestore.instance.collection('Users').doc(uid),
          }
        ],
        "state": "Assigned",
        "senderDetails": {},
        "cost": cost,
        "timestamp": Timestamp.now(),
      };

  String toString() {
    return 'Student: {pid: ${pid}, cost: ${cost}, loc : ${location}, recName : ${recipientName}, recAddNum : ${recipientAddressNUmber}, '
        'recStreet1 : ${recipientStreet1}, recStreet2 : ${recipientStreet2}, recCity : ${recipientCity}, ispending : ${isPending}, '
        'iscannotDeli : ${isCannotDelivered}, acceptPO : ${acceptedPO}, destiPO : ${destinationPO}, docId: ${docID}}';
  }
}
