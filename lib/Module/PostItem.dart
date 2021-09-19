abstract class PostItem {
  late String _pid;
  late List<double> _location = [];
  late String _recipientName;
  late String _recipientAddressNUmber;
  late String _recipientStreet;
  late String _recipientCity;
  late bool _isPending;
  late bool _isCannotDelivered;

  PostItem(String pid, List<double> loc, String recName, String recAdNum,
      String recStreet, String recCity) {
    this._pid = pid;
    this._location = loc;
    this._recipientName = recName;
    this._recipientAddressNUmber = recAdNum;
    this._recipientStreet = recStreet;
    this._recipientCity = recCity;
    this._isPending = true;
    this._isCannotDelivered = false;
  }

  String get getPid => _pid;

  List<double> get getLocation => _location;

  String get getRecipientName => _recipientName;

  String get getRecipientAddressNUmber => _recipientAddressNUmber;

  String get getRecipientStreet => _recipientStreet;

  String get getRecipientCity => _recipientCity;

  bool get getIsPending => _isPending;

  bool get getIsCannotDelivered => _isCannotDelivered;

  set setIsCannotDelivered(bool value) {
    _isCannotDelivered = value;
  }

  set setIsPending(bool value) {
    _isPending = value;
  }

  handleSuccessfulDelivery();
  handleFailedDelivery();
}
