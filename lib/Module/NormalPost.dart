import 'package:function_app/Module/PostItem.dart';

class NormalPost extends PostItem {
  NormalPost(String pid, List<double> loc, String recName, String recAdNum,
      String recStreet, String recCity)
      : super(pid, loc, recName, recAdNum, recStreet, recCity);

  @override
  handleFailedDelivery() {
    throw UnimplementedError();
  }

  @override
  handleSuccessfulDelivery() {
    throw UnimplementedError();
  }
}
