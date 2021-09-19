import 'package:flutter/material.dart';
import 'package:function_app/Module/NormalPost.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/PostItem.dart';
import 'package:function_app/Module/RegisteredPost.dart';

class PostData extends ChangeNotifier {
  List<NormalPost> _NormalPostList = [
    NormalPost('pid1', [7.0246668, 79.9671238], '111kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
    NormalPost('pid2', [7.0236778, 79.9682180], '222kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
    NormalPost('pid3', [7.0266599, 79.9693317], '333kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
    NormalPost('pid4', [7.0246720, 79.9673250], '44444kavishka', '129',
        'Batahena Rd', 'Kadawatha'),
  ];
  List<NormalPost> _NormalPostListRemaining = [];
  List<NormalPost> _NormalPostListUndelivered = [];

  List<NormalPost> get getNormalPostList => _NormalPostList;

  removeNormalPost(PostItem np) {
    this._NormalPostList.remove(np);
    notifyListeners();
  }

  removeRegisteredPost(PostItem np) {
    this._RegisteredPostList.remove(np);
    notifyListeners();
  }

  removepackagePost(PostItem np) {
    this._PackagePostList.remove(np);
    notifyListeners();
  }

  List<RegisteredPost> _RegisteredPostList = [
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
  ];
  List<RegisteredPost> _RegisteredPostListRemaining = [];
  List<RegisteredPost> _RegisteredPostListUndelivered = [];

  List<RegisteredPost> get getRegisteredPostList => _RegisteredPostList;

  List<PackagePost> _PackagePostList = [
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
  ];
  List<PackagePost> _PackagePostListRemaining = [];
  List<PackagePost> _PackagePostListUndelivered = [];

  List<PackagePost> get getPackagePostList => _PackagePostList;
}
