import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Services/NetworkServices.dart';

class RegisteredPost extends PostItem {
  String senderEmail;
  String senderAddressNUmber;
  String senderStreet1;
  String senderStreet2;
  String senderCity;
  String senderName;
  late String signature;

  RegisteredPost(
      {required String pid,
      required List<double> loc,
      required String recName,
      required String recAdNum,
      required String recStreet1,
      required String recStreet2,
      required String recCity,
      required this.senderName,
      required this.senderEmail,
      required this.senderAddressNUmber,
      required this.senderStreet1,
      required this.senderStreet2,
      required this.senderCity,
      required String cost,
      required bool ispending,
      required bool iscannotdel,
      required var acceptedPO,
      required String docID,
      required var destinationPO})
      : super(
            pid: pid,
            docID: docID,
            cost: cost,
            location: loc,
            recipientName: recName,
            recipientAddressNUmber: recAdNum,
            recipientStreet1: recStreet1,
            recipientStreet2: recStreet2,
            recipientCity: recCity,
            isPending: ispending,
            isCannotDelivered: iscannotdel,
            acceptedPO: acceptedPO,
            destinationPO: destinationPO);

  String get getSignature => signature;

  String get getSenderCity => senderCity;

  String get getSenderStreet1 => senderStreet1;

  String get getSenderStreet2 => senderStreet2;

  String get getSenderAddressNUmber => senderAddressNUmber;

  String get getSenderEmail => senderEmail;

  set setSignature(String value) {
    signature = value;
  }

  @override
  handleFailedDelivery(uid) async {
    return await NetworkService().PostFailed(uid, docID);
  }

  @override
  handleSuccessfulDelivery(signature, uid) async {
    // TODO: add signature function
    return await NetworkService()
        .PostDeliverySignature(uid, docID, this, signature);
  }

  restorePost() {}

  factory RegisteredPost.fromJson(Map<dynamic, dynamic> json, String docID) =>
      RegisteredPost(
        pid: json["pid"],
        loc: [],
        docID: docID,
        cost: json["cost"].toString(),
        acceptedPO: json["acceptedPostoffice"],
        destinationPO: json["destinationPostoffice"],
        recName: json["recipientDetails"]["recipientName"],
        recAdNum: json["recipientDetails"]["recipientAddressNo"],
        recStreet1: json["recipientDetails"]["recipientStreet1"],
        recStreet2: json["recipientDetails"]["recipientStreet2"],
        recCity: json["recipientDetails"]["recipientCity"],
        senderEmail: json["senderDetails"]["senderEmail"],
        ispending: true,
        iscannotdel: false,
        senderCity: json["senderDetails"]["senderCity"],
        senderStreet1: json["senderDetails"]["senderStreet1"],
        senderStreet2: json["senderDetails"]["senderStreet2"],
        senderAddressNUmber: json["senderDetails"]["senderAddressNo"],
        senderName: json["senderDetails"]["senderName"],
      );

  Map<String, dynamic> toJson(uid, signature, day) => {
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
        "senderDetails": {
          "senderAddressNo": senderAddressNUmber,
          "senderStreet1": senderStreet1,
          "senderStreet2": senderStreet2,
          "senderCity": senderCity,
          "senderName": senderName,
          "senderEmail": senderEmail,
        },
        "type": "RegisteredPost",
        "histories": [
          {
            'action': 'delivered',
            "employee": FirebaseFirestore.instance.collection('Users').doc(uid),
            "date": day,
          }
        ],
        "state": "Delivered",
        "cost": cost,
        "signature": "signatureRef",
        "timestamp": Timestamp.now(),
      };

  String toString() {
    return 'Student: {pid: ${pid}, cost: ${cost}, loc : ${location}, recName : ${recipientName}, recAddNum : ${recipientAddressNUmber}, '
        'recStreet1 : ${recipientStreet1}, recStreet2 : ${recipientStreet2}, recCity : ${recipientCity}, ispending : ${isPending}, '
        'iscannotDeli : ${isCannotDelivered}, acceptPO : ${acceptedPO}, destiPO : ${destinationPO}, docId: ${docID} , '
        'senderEmail : ${senderEmail} , senderAdNUm : ${senderAddressNUmber}, senderStreet1 : ${senderStreet1}, senderStreet : ${senderStreet2},senderCity : ${senderCity}';
  }
}
