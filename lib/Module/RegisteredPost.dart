import 'package:function_app/Module/PostItem.dart';

class RegisteredPost extends PostItem {
  late String _senderEmail;
  late String _senderAddressNUmber;
  late String _senderStreet;
  late String _senderCity;
  late String _signature;

  RegisteredPost(
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
  ) : super(pid, loc, recName, recAdNum, recStreet, recCity) {
    this._senderEmail = senEmail;
    this._senderAddressNUmber = senAdNum;
    this._senderStreet = senStreet;
    this._senderCity = senCity;
  }

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
