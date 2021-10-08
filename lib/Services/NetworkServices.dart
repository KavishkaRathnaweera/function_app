import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:geolocator/geolocator.dart';

import 'LocationServices.dart';

class NetworkService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> getUserRole(String uid) async {
    print(uid);

    CollectionReference users = _firestore.collection('Users');
    DocumentSnapshot snapshot = await users.doc('$uid').get();
    var data = snapshot.data() as Map;
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

      lis = templist.map((DocumentSnapshot docSnapshot) async {
        Map<String, dynamic> datap =
            docSnapshot.data()! as Map<String, dynamic>;
        var locDetails = await getAddress(
            datap["recipientDetails"]["recipientAddressNo"],
            datap["recipientDetails"]["recipientCity"],
            datap["recipientDetails"]["recipientStreet1"],
            datap["recipientDetails"]["recipientStreet2"]);
        docUIDMap[datap["pid"]] = [docSnapshot.id, locDetails];
        // fff[docSnapshot.data().] = docSnapshot.id;
        return docSnapshot.data();
      }).toList();

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
      List<dynamic> lis = [];

      QuerySnapshot collectionSnapshot = await serviceCollection.get();
      templist = collectionSnapshot.docs;

      lis = templist.map((DocumentSnapshot docSnapshot) {
        Map<String, dynamic> datap =
            docSnapshot.data()! as Map<String, dynamic>;
        docUIDMap[datap["pid"]] = docSnapshot.id;
        // fff[docSnapshot.data().] = docSnapshot.id;
        return docSnapshot.data();
      }).toList();

      lis.forEach((element) {
        if (postType == PostType.NormalPost && lis.isNotEmpty) {
          print(docUIDMap[element["pid"]]);
          NormalPost normalPost = NormalPost.fromJson(
              element, docUIDMap[element["pid"]], [0.0, 0.0]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost = RegisteredPost.fromJson(
              element, docUIDMap[element["pid"]], [0.0, 0.0]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost = PackagePost.fromJson(
              element, docUIDMap[element["pid"]], [0.0, 0.0]);
          returnList.add(packPost);
        }
      });
      return returnList;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<DatabaseResult> PostDelivery(uid, docID, postRef) async {
    print('a');
    bool isAdded = false;
    bool isDeleted = true;
    var erroradd;
    var errorDel;
    var initLocation;
    try {
      DateTime d = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('PendingMails').doc(docID);
      CollectionReference users = _firestore.collection('DeliveredMails');

      await users
          .add(postRef.toJson(uid, d))
          .then((value) => isAdded = true)
          .catchError((error) => erroradd = error);
      print('b');
      await documentReference
          .delete()
          .then((value) => isDeleted = true)
          .catchError((error) => errorDel = error);
      print(isAdded);
      print(erroradd);
      print('try');

      await addAddress(
          postRef.recipientAddressNUmber,
          postRef.recipientStreet1,
          postRef.recipientStreet2,
          postRef.recipientCity,
          postRef.location[0],
          postRef.location[1],
          false);

      print('address added');

      return DatabaseResult.Success;
    } catch (e) {
      print('error');
      if (isAdded && isDeleted) {
        return DatabaseResult.Success;
      } else if (isAdded && !isDeleted) {
        return DatabaseResult.OnlyAdded;
      } else if (isAdded && isDeleted) {
        return DatabaseResult.OnlyDelete;
      } else {
        return DatabaseResult.Failed;
      }
    }
  }

  Future<DatabaseResult> PostDeliverySignature(
      uid, docID, postRef, signature) async {
    bool isAdded = false;
    bool isDeleted = true;
    var erroradd;
    var errorDel;
    try {
      DateTime d = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('PendingMails').doc(docID);
      CollectionReference users = _firestore.collection('DeliveredMails');
      await users
          .add(postRef.toJson(uid, signature, d))
          .then((value) => isAdded = true)
          .catchError((error) => erroradd = error);

      // await documentReference
      //     .delete()
      //     .then((value) => isDeleted = true)
      //     .catchError((error) => errorDel = error);

      await addAddress(
          postRef.recipientAddressNUmber,
          postRef.recipientStreet1,
          postRef.recipientStreet2,
          postRef.recipientCity,
          postRef.location[0],
          postRef.location[1],
          false);
      return DatabaseResult.Success;
    } catch (e) {
      if (isAdded && isDeleted) {
        return DatabaseResult.Success;
      } else if (isAdded && !isDeleted) {
        return DatabaseResult.OnlyAdded;
      } else if (isAdded && isDeleted) {
        return DatabaseResult.OnlyDelete;
      } else {
        return DatabaseResult.Failed;
      }
    }
  }

  Future<DatabaseResult> PostFailed(uid, docID, postRef) async {
    bool isUpdated = false;
    var updateError;
    try {
      await addAddress(
          postRef.recipientAddressNUmber,
          postRef.recipientStreet1,
          postRef.recipientStreet2,
          postRef.recipientCity,
          postRef.location[0],
          postRef.location[1],
          false);
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

      return DatabaseResult.Success;
    } catch (e) {
      if (isUpdated) {
        return DatabaseResult.Success;
      } else {
        return DatabaseResult.Failed;
      }
    }
  }

  Future<List<double>> getAddress(adnum, city, street1, street2) async {
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
      Map<String, dynamic> datap = docSnapshot.data()! as Map<String, dynamic>;
      return [datap['location'].latitude, datap['location'].longitude];
    } else {
      return [0.0, 0.0];
    }
  }

  Future<bool> addAddress(String adnum, String street1, String street2,
      String city, double latitude, double longitude, bool update) async {
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
  }
}
