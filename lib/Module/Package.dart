import 'package:function_app/Module/PostItem.dart';

class PackagePost extends PostItem {
  late String _senderEmail;
  late String _senderAddressNUmber;
  late String _senderStreet;
  late String _senderCity;
  late String _signature;
  late int _weight;
  late String _receiverEmail;

  PackagePost(
    String pid,
    List<double> loc,
    String recName,
    String recAdNum,
    String recStreet,
    String recCity,
    String senEmail,
    String senAdNum,
    String senStreet,
    String senCity,
    String recEmail,
    int weight,
  ) : super(pid, loc, recName, recAdNum, recStreet, recCity) {
    this._senderEmail = senEmail;
    this._senderAddressNUmber = senAdNum;
    this._senderStreet = senStreet;
    this._senderCity = senCity;
    this._receiverEmail = recEmail;
    this._weight = weight;
  }

  int get getWeight => _weight;

  String get getReceiverEmail => _receiverEmail;

  String get getSignature => _signature;

  String get getSenderCity => _senderCity;

  String get getSenderStreet => _senderStreet;

  String get getSenderAddressNUmber => _senderAddressNUmber;

  String get getSenderEmail => _senderEmail;

  set setSignature(String value) {
    _signature = value;
  }

  @override
  handleFailedDelivery() {
    // TODO: implement handleFailedDelivery
    throw UnimplementedError();
  }

  @override
  handleSuccessfulDelivery() {
    // TODO: implement handleSuccessfulDelivery
    throw UnimplementedError();
  }
}
