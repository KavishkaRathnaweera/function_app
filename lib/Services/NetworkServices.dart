import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:function_app/Services/EmailService.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NetworkService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> getUserRole(String uid) async {
    print(uid);

    CollectionReference users = _firestore.collection('Users');
    DocumentSnapshot snapshot = await users.doc('$uid').get();
    var data = snapshot.data() as Map;

    try {
      if (data['role'] == 'postman') {
        QuerySnapshot locs =
            await users.doc('$uid').collection('locations').get();
        var locdetails = locs.docs;
        if (locdetails.isEmpty) {
          await users.doc('$uid').collection('locations').add({
            "geoLocations": [
              {'location': GeoPoint(0, 0), "timestamp": Timestamp.now()}
            ],
            "date": "0000/00/00",
          });
        }
      }
    } catch (e) {}

    return data;
  }

  Future<List<PostItem>?> getServices(PostType postType, String uid) async {
    var docRef = _firestore.collection('Users').doc(uid);
    final serviceCollection;
    if (postType == PostType.NormalPost) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'NormalPost')
          .where('histories', arrayContains: {
        'action': 'Assigned',
        'employee': docRef
      }).where('state', isEqualTo: 'Assigned');
    } else if (postType == PostType.RegisteredPost) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'RegisteredPost')
          .where('histories', arrayContains: {
        'action': 'Assigned',
        'employee': docRef
      }).where('state', isEqualTo: 'Assigned');
    } else if (postType == PostType.Package) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'Package')
          .where('histories', arrayContains: {
        'action': 'Assigned',
        'employee': docRef
      }).where('state', isEqualTo: 'Assigned');
    } else {
      return null;
    }
//deliverAttempt
    try {
      List<DocumentSnapshot> templist;
      List<PostItem> returnList = [];
      Map docUIDMap = {};
      Map locAddress = {};
      List<dynamic> lis = [];

      QuerySnapshot collectionSnapshot = await serviceCollection.get();
      templist = collectionSnapshot.docs;

      lis = templist.map((DocumentSnapshot docSnapshot) {
        Map<String, dynamic> datap =
            docSnapshot.data()! as Map<String, dynamic>;
        docUIDMap[datap["pid"]] = [
          docSnapshot.id,
          datap["recipientDetails"]["recipientAddressNo"],
          datap["recipientDetails"]["recipientCity"],
          datap["recipientDetails"]["recipientStreet1"],
          datap["recipientDetails"]["recipientStreet2"]
        ];
        return docSnapshot.data();
      }).toList();

      print('start');
      await Future.forEach(docUIDMap.keys, (elem) async {
        locAddress[elem] = await getAddress(docUIDMap[elem][1],
            docUIDMap[elem][2], docUIDMap[elem][3], docUIDMap[elem][4]);
        print(locAddress[elem]);
      });
      print('done');

      lis.forEach((element) {
        if (postType == PostType.NormalPost && lis.isNotEmpty) {
          print(element["pid"]);
          NormalPost normalPost = NormalPost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost = RegisteredPost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost = PackagePost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(packPost);
        }
      });

      return returnList;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<PostItem>?> getServicesUndeliverable(
      PostType postType, String uid) async {
    var docRef = _firestore.collection('Users').doc(uid);
    DateTime d =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final serviceCollection;
    if (postType == PostType.NormalPost) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'NormalPost')
          .where('histories', arrayContains: {
        'action': 'DeliverAttempted',
        'date': d,
        'employee': docRef,
      }).where('state', isEqualTo: 'DeliverAttempted');
    } else if (postType == PostType.RegisteredPost) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'RegisteredPost')
          .where('histories', arrayContains: {
        'action': 'DeliverAttempted',
        'date': d,
        'employee': docRef,
      }).where('state', isEqualTo: 'DeliverAttempted');
    } else if (postType == PostType.Package) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'Package')
          .where('histories', arrayContains: {
        'action': 'DeliverAttempted',
        'date': d,
        'employee': docRef,
      }).where('state', isEqualTo: 'DeliverAttempted');
    } else {
      return null;
    }
//deliverAttempt
    try {
      List<DocumentSnapshot> templist;
      List<PostItem> returnList = [];
      Map docUIDMap = {};
      Map locAddress = {};
      List<dynamic> lis = [];

      QuerySnapshot collectionSnapshot = await serviceCollection.get();
      templist = collectionSnapshot.docs;

      lis = templist.map((DocumentSnapshot docSnapshot) {
        Map<String, dynamic> datap =
            docSnapshot.data()! as Map<String, dynamic>;
        docUIDMap[datap["pid"]] = [
          docSnapshot.id,
          datap["recipientDetails"]["recipientAddressNo"],
          datap["recipientDetails"]["recipientCity"],
          datap["recipientDetails"]["recipientStreet1"],
          datap["recipientDetails"]["recipientStreet2"]
        ];
        return docSnapshot.data();
      }).toList();

      print("startUNDel");
      await Future.forEach(docUIDMap.keys, (elem) async {
        locAddress[elem] = await getAddress(docUIDMap[elem][1],
            docUIDMap[elem][2], docUIDMap[elem][3], docUIDMap[elem][4]);
        print(locAddress[elem]);
      });

      lis.forEach((element) {
        if (postType == PostType.NormalPost && lis.isNotEmpty) {
          print(docUIDMap[element["pid"]]);
          NormalPost normalPost = NormalPost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost = RegisteredPost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost = PackagePost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(packPost);
        }
      });
      return returnList;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<PostItem>?> getServicesDeivered(
      PostType postType, String uid) async {
    var docRef = _firestore.collection('Users').doc(uid);
    DateTime d =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final serviceCollection;
    if (postType == PostType.NormalPost) {
      serviceCollection = _firestore
          .collection('DeliveredMails')
          .where('type', isEqualTo: 'NormalPost')
          .where('histories', arrayContains: {
        'action': 'Delivered',
        'employee': docRef,
        'date': d,
      }).where('state', isEqualTo: 'Delivered');
    } else if (postType == PostType.RegisteredPost) {
      serviceCollection = _firestore
          .collection('DeliveredMails')
          .where('type', isEqualTo: 'RegisteredPost')
          .where('histories', arrayContains: {
        'action': 'Delivered',
        'employee': docRef,
        'date': d,
      }).where('state', isEqualTo: 'Delivered');
    } else if (postType == PostType.Package) {
      serviceCollection = _firestore
          .collection('DeliveredMails')
          .where('type', isEqualTo: 'Package')
          .where('histories', arrayContains: {
        'action': 'Delivered',
        'employee': docRef,
        'date': d,
      }).where('state', isEqualTo: 'Delivered');
    } else {
      return null;
    }

//deliverAttempt
    try {
      List<DocumentSnapshot> templist;
      List<PostItem> returnList = [];
      Map docUIDMap = {};
      Map locAddress = {};
      List<dynamic> lis = [];

      QuerySnapshot collectionSnapshot = await serviceCollection.get();
      templist = collectionSnapshot.docs;

      lis = templist.map((DocumentSnapshot docSnapshot) {
        Map<String, dynamic> datap =
            docSnapshot.data()! as Map<String, dynamic>;
        docUIDMap[datap["pid"]] = [
          docSnapshot.id,
          datap["recipientDetails"]["recipientAddressNo"],
          datap["recipientDetails"]["recipientCity"],
          datap["recipientDetails"]["recipientStreet1"],
          datap["recipientDetails"]["recipientStreet2"]
        ];
        return docSnapshot.data();
      }).toList();

      print("startDel");
      await Future.forEach(docUIDMap.keys, (elem) async {
        locAddress[elem] = await getAddress(docUIDMap[elem][1],
            docUIDMap[elem][2], docUIDMap[elem][3], docUIDMap[elem][4]);
        print(locAddress[elem]);
      });
      lis.forEach((element) {
        if (postType == PostType.NormalPost && lis.isNotEmpty) {
          print(docUIDMap[element["pid"]]);
          NormalPost normalPost = NormalPost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost = RegisteredPost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost = PackagePost.fromJson(element,
              docUIDMap[element["pid"]][0], locAddress[element["pid"]]);
          returnList.add(packPost);
        }
      });
      return returnList;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<DatabaseResult> PostDelivery(
      uid, docID, postRef, updateAddress) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {}
    if (isConnected) {
      try {
        DateTime d = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection('PendingMails').doc(docID);
        CollectionReference users = _firestore.collection('DeliveredMails');

        WriteBatch writeBatch = _firestore.batch();
        writeBatch.set(users.doc(docID), postRef.toJson(uid, d));
        writeBatch.delete(documentReference);
        writeBatch.commit();

        if (postRef.location[0] != 0.0 && updateAddress) {
          await addAddress(
              postRef.recipientAddressNUmber,
              postRef.recipientStreet1,
              postRef.recipientStreet2,
              postRef.recipientCity,
              postRef.location[0],
              postRef.location[1],
              false);
        }

        await updateUserLocation(postRef.location);

        print('address added');

        return DatabaseResult.Success;
      } catch (e) {
        print('error');
        return DatabaseResult.Failed;
      }
    } else {
      return DatabaseResult.Failed;
    }
  }

  Future<DatabaseResult> PostDeliverySignature(
      uid, docID, postRef, signature, updateAddress) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {}
    if (isConnected) {
      try {
        DateTime d = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection('PendingMails').doc(docID);
        CollectionReference users = _firestore.collection('DeliveredMails');

        WriteBatch writeBatch = _firestore.batch();
        writeBatch.set(users.doc(docID), postRef.toJson(uid, signature, d));
        writeBatch.delete(documentReference);
        writeBatch.commit();

        if (postRef.location[0] != 0.0 && updateAddress) {
          await addAddress(
              postRef.recipientAddressNUmber,
              postRef.recipientStreet1,
              postRef.recipientStreet2,
              postRef.recipientCity,
              postRef.location[0],
              postRef.location[1],
              false);
        }

        await uploadImageData(signature,
            '${postRef.recipientName}_${postRef.recipientStreet1}_${postRef.recipientStreet2}_${postRef.recipientCity}');

        await EmailSender.deliveredEmailOperator(postRef);
        await updateUserLocation(postRef.location);
        return DatabaseResult.Success;
      } catch (e) {
        return DatabaseResult.Failed;
      }
    } else {
      return DatabaseResult.Failed;
    }
  }

  Future<void> uploadImageData(signature, fileName) async {
    final date =
        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('signatures/$date/$fileName');
    try {
      await ref.putData(signature);
    } catch (e) {}
  }

  Future<DatabaseResult> PostFailed(uid, docID, postRef, updateAddress) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {}
    if (isConnected) {
      bool isUpdated = false;
      var updateError;
      try {
        var docRef = _firestore.collection('Users').doc(uid);
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection('PendingMails').doc(docID);
        DateTime d = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        await documentReference
            .update({
              'histories': FieldValue.arrayUnion([
                {'action': 'DeliverAttempted', 'date': d, 'employee': docRef}
              ]),
              'state': 'DeliverAttempted',
            })
            .then((value) => isUpdated = true)
            .catchError((error) => updateError = error);

        print(postRef.location[0]);
        if (postRef.location[0] != 0.0 && updateAddress) {
          await addAddress(
              postRef.recipientAddressNUmber,
              postRef.recipientStreet1,
              postRef.recipientStreet2,
              postRef.recipientCity,
              postRef.location[0],
              postRef.location[1],
              false);
        }
        await EmailSender.failedEmailOperator(postRef);
        await updateUserLocation(postRef.location);

        return DatabaseResult.Success;
      } catch (e) {
        if (isUpdated) {
          return DatabaseResult.Success;
        } else {
          return DatabaseResult.Failed;
        }
      }
    } else {
      return DatabaseResult.Failed;
    }
  }

  Future<DatabaseResult> PostRestore(uid, docID, postRef) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {}
    if (isConnected) {
      try {
        DocumentReference documentReference =
            _firestore.collection('DeliveredMails').doc(docID);
        CollectionReference users = _firestore.collection('PendingMails');

        CollectionReference userDetails = _firestore.collection('Users');
        DocumentSnapshot snapshot = await userDetails.doc('$uid').get();
        var data = snapshot.data() as Map;

        DocumentReference postOffice = data['postOffice'];
        DocumentSnapshot postOfficeDetails = await postOffice.get();
        var postData = postOfficeDetails.data() as Map;

        WriteBatch writeBatch = _firestore.batch();
        writeBatch.set(
            users.doc(docID), postRef.toJsonPending(uid, postData['location']));
        writeBatch.delete(documentReference);
        writeBatch.commit();

        return DatabaseResult.Success;
      } catch (e) {
        print('error');
        return DatabaseResult.Failed;
      }
    } else {
      return DatabaseResult.Failed;
    }
  }

  Future<List<double>> getAddress(adnum, city, street1, street2) async {
    try {
      CollectionReference addLoc = _firestore.collection('AddressLocations');
      var serviceCollection = addLoc
          .where('address.addressNumber', isEqualTo: adnum)
          .where('address.city', isEqualTo: city)
          .where('address.street1', isEqualTo: street1)
          .where('address.street2', isEqualTo: street2);

      QuerySnapshot collectionSnapshot = await serviceCollection.get();
      List<DocumentSnapshot> templist = collectionSnapshot.docs;
      if (templist.length == 1) {
        DocumentSnapshot docSnapshot = templist[0];
        Map<String, dynamic> datap =
            docSnapshot.data()! as Map<String, dynamic>;
        return [datap['location'].latitude, datap['location'].longitude];
      } else {
        return [0.0, 0.0];
      }
    } catch (e) {
      return [0.0, 0.0];
    }
  }

  Future<bool> addAddress(String adnum, String street1, String street2,
      String city, double latitude, double longitude, bool update) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {}
    if (isConnected) {
      bool isAdded = false;
      bool isUpdated = false;
      var updateError;
      var erroradd;
      GeoPoint point = GeoPoint(latitude, longitude);
      CollectionReference addLoc = _firestore.collection('AddressLocations');
      var serviceCollection = addLoc
          .where('address.addressNumber', isEqualTo: adnum)
          .where('address.city', isEqualTo: city)
          .where('address.street1', isEqualTo: street1)
          .where('address.street2', isEqualTo: street2);

      QuerySnapshot collectionSnapshot = await serviceCollection.get();
      List<DocumentSnapshot> templist = collectionSnapshot.docs;
      if (templist.isEmpty) {
        await addLoc
            .add({
              "address": {
                "addressNumber": adnum,
                "city": city,
                "street1": street1,
                "street2": street2
              },
              "location": point,
            })
            .then((value) => isAdded = true)
            .catchError((error) => erroradd = error);
      } else if (templist.length == 1) {
        if (update) {
          DocumentReference documentReference = addLoc.doc(templist[0].id);
          await documentReference
              .update({
                'location': point,
              })
              .then((value) => isUpdated = true)
              .catchError((error) => updateError = error);
        }
      }
      return isUpdated || isAdded;
    } else {
      return false;
    }
  }

  Future<void> updateUserLocation(location) async {
    bool isAdded = false;
    bool isUpdated = false;
    var uid = _auth.currentUser!.uid;
    var day = DateTime.now().day < 10
        ? '0${DateTime.now().day}'
        : '${DateTime.now().day}';
    final date = '${DateTime.now().year}/${DateTime.now().month}/$day';
    var locationCol =
        _firestore.collection('Users').doc(uid).collection('locations');

    QuerySnapshot collectionSnapshot =
        await locationCol.where('date', isEqualTo: date).get();
    List<DocumentSnapshot> templist = collectionSnapshot.docs;
    if (templist.isEmpty) {
      await locationCol
          .add({
            "geoLocations": [
              {
                'location': GeoPoint(location[0], location[1]),
                "timestamp": Timestamp.now()
              }
            ],
            "date": date,
          })
          .then((value) => isAdded = true)
          .catchError((error) => error);
    } else if (templist.length == 1) {
      DocumentReference documentReference = locationCol.doc(templist[0].id);
      await documentReference
          .update({
            'geoLocations': FieldValue.arrayUnion([
              {
                'location': GeoPoint(location[0], location[1]),
                "timestamp": Timestamp.now()
              }
            ]),
          })
          .then((value) => isUpdated = true)
          .catchError((error) => error);
    } else {
      print('Database error');
    }
  }

  Future<DatabaseResult> changeBundleLocation(
      bool isDestination, String barcode, Position loc) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {}
    if (isConnected) {
      try {
        CollectionReference transfers = _firestore.collection('Transfers');
        DocumentSnapshot snapshot = await transfers.doc('$barcode').get();
        var data = snapshot.data() as Map;
        data['mails'].forEach((element) {
          print(element);
        });
        if (isDestination) {
          await Future.forEach(data['mails'], (element) async {
            element as DocumentReference;
            element.update({
              'locations': FieldValue.arrayUnion([
                {
                  'location': GeoPoint(loc.latitude, loc.longitude),
                  "timestamp": Timestamp.now()
                }
              ]),
              'state': 'DestinationArrived',
            });
          });
        } else {
          await Future.forEach(data['mails'], (element) async {
            element as DocumentReference;
            element.update({
              'locations': FieldValue.arrayUnion([
                {
                  'location': GeoPoint(loc.latitude, loc.longitude),
                  "timestamp": Timestamp.now()
                }
              ]),
            });
          });
        }

        return DatabaseResult.Success;
      } catch (e) {
        print("Failed");
        return DatabaseResult.Failed;
      }
    } else {
      return DatabaseResult.Failed;
    }
  }
}
