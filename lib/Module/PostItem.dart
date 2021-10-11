import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostItem {
  String pid;
  String cost;
  var acceptedPO;
  var destinationPO;
  List<double> location = [];
  String recipientName;
  String recipientAddressNUmber;
  String recipientStreet1;
  String recipientStreet2;
  String recipientCity;
  bool isPending;
  bool isCannotDelivered;
  String docID;

  PostItem({
    required this.pid,
    required this.cost,
    required this.location,
    required this.recipientName,
    required this.recipientAddressNUmber,
    required this.recipientStreet1,
    required this.recipientStreet2,
    required this.recipientCity,
    required this.isPending,
    required this.isCannotDelivered,
    required this.acceptedPO,
    required this.destinationPO,
    required this.docID,
  });

  String get getPid => pid;

  List<double> get getLocation => location;

  String get getRecipientName => recipientName;

  String get getRecipientAddressNUmber => recipientAddressNUmber;

  String get getRecipientStreet1 => recipientStreet1;

  String get getRecipientStreet2 => recipientStreet2;

  String get getRecipientCity => recipientCity;

  bool get getIsPending => isPending;

  bool get getIsCannotDelivered => isCannotDelivered;

  setIsCannotDelivered(bool value) {
    isCannotDelivered = value;
  }

  setIsPending(bool value) {
    isPending = value;
  }

  setLocation(List<double> v) {
    location = v;
  }

  handleSuccessfulDelivery(signature, uid, locPosition);
  handleFailedDelivery(uid, locPosition);
  restorePost();
}

/*
(String pid, List<double> loc, String recName, String recAdNum,
      String recStreet, String recCity)
 */

/*
import 'dart:convert';

OneService OneServiceFromJson(String str) =>
    OneService.fromJson(json.decode(str));

String OneServiceToJson(OneService data) => json.encode(data.toJson());

class OneService {
  OneService({
    this.image,
    this.docID,
    this.name,
    this.price,
    this.rating,
    this.serviceCategory,
  });

  String image;
  String name;
  double price;
  double rating;
  int ratingSum;
  int ratingCount;
  String serviceCategory;
  String docID;

  factory OneService.fromJson(Map<dynamic, dynamic> json) => OneService(
        image: json["image"],
        docID: json["docID"],
        name: json["name"],
        price: json["price"].toDouble(),
        rating: json["rating"].toDouble(),
        serviceCategory: json["service_category"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "docID": docID,
        "name": name,
        "price": price,
        "rating": rating,
        "service_category": serviceCategory,
      };
}
 */
