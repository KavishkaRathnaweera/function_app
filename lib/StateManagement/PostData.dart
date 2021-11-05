import 'package:flutter/material.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:function_app/Components/ConstantFile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostData extends ChangeNotifier {
  String uid = "";

  List<PostItem> _NormalPostList = [];
  List<PostItem> _NormalPostListDelivered = [];
  List<PostItem> _NormalPostListUndelivereble = [];

  List<PostItem> get getNormalPostList => _NormalPostList;
  List<PostItem> get getNormalPostListDelievered => _NormalPostListDelivered;
  List<PostItem> get getNormalPostListUndelivereble =>
      _NormalPostListUndelivereble;

  setNormalPostList(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is NormalPost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _NormalPostList = value;
    }
    // _NormalPostList = value;
  }

  setNormalPostListDelivered(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is NormalPost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _NormalPostListDelivered = value;
    }
  }

  setNormalPostListUndelivereble(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is NormalPost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _NormalPostListUndelivereble = value;
    }
  }

  removeNormalPost(np, PostAction pa) {
    if (pa == PostAction.Success) {
      this._NormalPostListDelivered.add(np);
    } else if (pa == PostAction.Fail) {
      this._NormalPostListUndelivereble.add(np);
    }
    this._NormalPostList.remove(np);
    notifyListeners();
  }

  removeNormalPostUndeliverable(np) {
    this._NormalPostListDelivered.add(np);
    this._NormalPostListUndelivereble.remove(np);
    notifyListeners();
  }

  removeNormalPostDelievered(np) {
    this._NormalPostList.add(np);
    this._NormalPostListDelivered.remove(np);
    notifyListeners();
  }

  List<PostItem> _RegisteredPostList = [];
  List<PostItem> _RegisteredPostListDelievered = [];
  List<PostItem> _RegisteredPostListUndeliverable = [];

  List<PostItem> get getRegisteredPostList => _RegisteredPostList;
  List<PostItem> get getRegisteredPostListDelievered =>
      _RegisteredPostListDelievered;
  List<PostItem> get getRegisteredPostListUndeliverable =>
      _RegisteredPostListUndeliverable;

  setRegisteredPostList(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is RegisteredPost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _RegisteredPostList = value;
    }
  }

  setRegisteredPostListDelivered(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is RegisteredPost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _RegisteredPostListDelievered = value;
    }
  }

  setRegisteredPostListUndelivereble(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is RegisteredPost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _RegisteredPostListUndeliverable = value;
    }
  }

  removeRegisteredPost(np, PostAction pa) {
    if (pa == PostAction.Success) {
      this._RegisteredPostListDelievered.add(np);
    } else if (pa == PostAction.Fail) {
      this._RegisteredPostListUndeliverable.add(np);
    }
    this._RegisteredPostList.remove(np);
    notifyListeners();
  }

  removeRegisteredPostUndeliverable(np) {
    this._RegisteredPostListDelievered.add(np);
    this._RegisteredPostListUndeliverable.remove(np);
    notifyListeners();
  }

  removeRegisteredPostDelievered(np) {
    this._RegisteredPostList.add(np);
    this._RegisteredPostListDelievered.remove(np);
    notifyListeners();
  }

  List<PostItem> _PackagePostList = [];
  List<PostItem> _PackagePostListDelivered = [];
  List<PostItem> _PackagePostListUndeleverable = [];

  List<PostItem> get getPackagePostList => _PackagePostList;
  List<PostItem> get getPackagePostListDelivered => _PackagePostListDelivered;
  List<PostItem> get getPackagePostListUndeleverable =>
      _PackagePostListUndeleverable;

  setPackagePostList(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is PackagePost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _PackagePostList = value;
    }
  }

  setPackagePostDelivered(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is PackagePost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _PackagePostListDelivered = value;
    }
  }

  setPackagePostListUndelivereble(List<PostItem> value) {
    bool isValid = true;
    value.forEach((element) {
      if (!(element is PackagePost)) {
        isValid = false;
      }
    });
    if (isValid) {
      _PackagePostListUndeleverable = value;
    }
  }

  removePackagePost(np, PostAction pa) {
    if (pa == PostAction.Success) {
      this._PackagePostListDelivered.add(np);
    } else if (pa == PostAction.Fail) {
      this._PackagePostListUndeleverable.add(np);
    }
    this._PackagePostList.remove(np);
    notifyListeners();
  }

  removePackagePostUndeliverable(np) {
    this._PackagePostListDelivered.add(np);
    this._PackagePostListUndeleverable.remove(np);
    notifyListeners();
  }

  removePackagePostDelievered(np) {
    this._PackagePostList.add(np);
    this._PackagePostListDelivered.remove(np);
    notifyListeners();
  }

  Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  addMarkerRemaining(List<PostItem> postList, bool empty) {
    if (empty) {
      _markers.clear();
    }
    if (postList.isNotEmpty) {
      var type;
      if (postList[0] is NormalPost) {
        type = 'Normal';
      } else if (postList[0] is RegisteredPost) {
        type = 'Registered';
      } else if (postList[0] is PackagePost) {
        type = 'Package';
      } else {
        type = 'Unknown';
      }
      postList.forEach((element) {
        if (element.location[0] != 0.0) {
          final markerIntance = Marker(
            markerId: MarkerId(element.pid),
            infoWindow: InfoWindow(
                title:
                    '${element.recipientAddressNUmber} , ${element.getRecipientStreet1} road, ${element.getRecipientStreet2} ${element.getRecipientCity}',
                snippet:
                    'Name : ${element.recipientName} Type : $type post Remaining'),
            position: LatLng(element.location[0], element.location[1]),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
          );
          _markers.add(markerIntance);
          print(element.location[0]);
          print(element.location[1]);
        }
      });
    }
    // notifyListeners();
  }

  addMarkerUndeliverable(List<PostItem> postList, bool empty) {
    if (postList.isNotEmpty) {
      var type;
      if (postList[0] is NormalPost) {
        type = 'Normal';
      } else if (postList[0] is RegisteredPost) {
        type = 'Registered';
      } else if (postList[0] is PackagePost) {
        type = 'Package';
      } else {
        type = 'Unknown';
      }
      postList.forEach((element) {
        if (element.location[0] != 0.0) {
          final markerIntance = Marker(
            markerId: MarkerId(element.pid),
            infoWindow: InfoWindow(
                title:
                    '${element.recipientAddressNUmber} , ${element.getRecipientStreet1} road, ${element.getRecipientStreet2} ${element.getRecipientCity}',
                snippet:
                    'Name : ${element.recipientName} Type : $type post Undeliverable'),
            position: LatLng(element.location[0], element.location[1]),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          );
          _markers.add(markerIntance);
          print(element.location[0]);
          print(element.location[1]);
        }
      });
    }
  }
}
