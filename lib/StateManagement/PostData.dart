import 'package:flutter/material.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:function_app/Components/ConstantFile.dart';

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
}

/*
    RegisteredPost(
        'pid1',
        [7.0246668, 79.9671238],
        'Rkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle'),
    RegisteredPost(
        'pid2',
        [7.0236778, 79.9682180],
        'Rkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle'),
    RegisteredPost(
        'pid3',
        [7.0266599, 79.9693317],
        'Rkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle'),
    RegisteredPost(
        'pid4',
        [7.0246720, 79.9673250],
        'Rkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle'),
 */

/*
PackagePost(
        'pid1',
        [7.0246668, 79.9671238],
        'Pkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle',
        'kavishka@gmail.com',
        20),
    PackagePost(
        'pid2',
        [7.0236778, 79.9682180],
        'Pkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle',
        'kavishka@gmail.com',
        20),
    PackagePost(
        'pid3',
        [7.0266599, 79.9693317],
        'Pkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle',
        'kavishka@gmail.com',
        20),
    PackagePost(
        'pid4',
        [7.0246720, 79.9673250],
        'Pkavishka',
        '129',
        'Batahena Rd',
        'Kadawatha',
        'charuka@gmail.com',
        '222',
        'colombo rd',
        'Galle',
        'kavishka@gmail.com',
        20),
 */

/*

    NormalPost('pid1', [7.0246668, 79.9671238], '111kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
    NormalPost('pid2', [7.0236778, 79.9682180], '222kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
    NormalPost('pid3', [7.0266599, 79.9693317], '333kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
    NormalPost('pid4', [7.0246720, 79.9673250], '44444kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
 */
