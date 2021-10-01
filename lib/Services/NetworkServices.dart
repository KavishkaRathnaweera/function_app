import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';

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
          NormalPost normalPost =
              NormalPost.fromJson(element, docUIDMap[element["pid"]]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost =
              RegisteredPost.fromJson(element, docUIDMap[element["pid"]]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost =
              PackagePost.fromJson(element, docUIDMap[element["pid"]]);
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
        'action': 'deliverAttempted',
        'date': d,
        'employee': docRef,
      }).where('state', isEqualTo: 'DeliverAttempted');
    } else if (postType == PostType.RegisteredPost) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'RegisteredPost')
          .where('histories', arrayContains: {
        'action': 'deliverAttempted',
        'date': d,
        'employee': docRef,
      }).where('state', isEqualTo: 'DeliverAttempted');
    } else if (postType == PostType.Package) {
      serviceCollection = _firestore
          .collection('PendingMails')
          .where('type', isEqualTo: 'Package')
          .where('histories', arrayContains: {
        'action': 'deliverAttempted',
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
          NormalPost normalPost =
              NormalPost.fromJson(element, docUIDMap[element["pid"]]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost =
              RegisteredPost.fromJson(element, docUIDMap[element["pid"]]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost =
              PackagePost.fromJson(element, docUIDMap[element["pid"]]);
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
        'action': 'delivered',
        'employee': docRef,
        'date': d,
      }).where('state', isEqualTo: 'Delivered');
    } else if (postType == PostType.RegisteredPost) {
      serviceCollection = _firestore
          .collection('DeliveredMails')
          .where('type', isEqualTo: 'RegisteredPost')
          .where('histories', arrayContains: {
        'action': 'delivered',
        'employee': docRef,
        'date': d,
      }).where('state', isEqualTo: 'Delivered');
    } else if (postType == PostType.Package) {
      serviceCollection = _firestore
          .collection('DeliveredMails')
          .where('type', isEqualTo: 'Package')
          .where('histories', arrayContains: {
        'action': 'delivered',
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
          NormalPost normalPost =
              NormalPost.fromJson(element, docUIDMap[element["pid"]]);
          returnList.add(normalPost);
        } else if (postType == PostType.RegisteredPost) {
          print(element["pid"]);
          RegisteredPost regPost =
              RegisteredPost.fromJson(element, docUIDMap[element["pid"]]);
          returnList.add(regPost);
        } else if (postType == PostType.Package) {
          print(element["pid"]);
          PackagePost packPost =
              PackagePost.fromJson(element, docUIDMap[element["pid"]]);
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
    DateTime d =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    bool isAdded = false;
    bool isDeleted = true;
    var erroradd;
    var errorDel;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('PendingMails').doc(docID);
    CollectionReference users = _firestore.collection('DeliveredMails');
    await users
        .add(postRef.toJson(uid, d))
        .then((value) => isAdded = true)
        .catchError((error) => erroradd = error);

    // await documentReference
    //     .delete()
    //     .then((value) => isDeleted=true)
    //     .catchError((error) => errorDel = error);
    print(isAdded);
    print(erroradd);

    if (isAdded && isDeleted) {
      return DatabaseResult.Success;
    } else if (isAdded) {
      return DatabaseResult.OnlyAdded;
    } else if (isDeleted) {
      return DatabaseResult.OnlyDelete;
    } else {
      return DatabaseResult.Failed;
    }
  }

  Future<DatabaseResult> PostDeliverySignature(
      uid, docID, postRef, signature) async {
    DateTime d =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    bool isAdded = false;
    bool isDeleted = true;
    var erroradd;
    var errorDel;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('PendingMails').doc(docID);
    CollectionReference users = _firestore.collection('DeliveredMails');
    await users
        .add(postRef.toJson(uid, signature, d))
        .then((value) => isAdded = true)
        .catchError((error) => erroradd = error);

    // await documentReference
    //     .delete()
    //     .then((value) => isDeleted=true)
    //     .catchError((error) => errorDel = error);
    print(isAdded);
    print(erroradd);

    if (isAdded && isDeleted) {
      return DatabaseResult.Success;
    } else if (isAdded) {
      return DatabaseResult.OnlyAdded;
    } else if (isDeleted) {
      return DatabaseResult.OnlyDelete;
    } else {
      return DatabaseResult.Failed;
    }
  }

  Future<DatabaseResult> PostFailed(uid, docID) async {
    bool isUpdated = false;
    var updateError;
    var docRef = _firestore.collection('Users').doc(uid);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('PendingMails').doc(docID);
    DateTime d =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    await documentReference
        .update({
          'histories': FieldValue.arrayUnion([
            {'action': 'deliverAttempted', 'date': d, 'employee': docRef}
          ]),
          'state': 'DeliverAttempted',
        })
        .then((value) => isUpdated = true)
        .catchError((error) => updateError = error);

    print(isUpdated);

    if (isUpdated) {
      return DatabaseResult.Success;
    } else {
      return DatabaseResult.Failed;
    }
  }
}
