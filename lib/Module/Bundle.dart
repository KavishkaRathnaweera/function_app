import 'package:function_app/Components/ConstantFile.dart';
import 'package:function_app/Services/NetworkServices.dart';
import 'package:geolocator/geolocator.dart';

class Bundle {
  String barcode;
  DateTime dateTime;

  Bundle({required this.barcode, required this.dateTime});

  Future<DatabaseResult> updateLocation(
      Position loc, bool isDestination) async {
    return await NetworkService()
        .changeBundleLocation(isDestination, this.barcode, loc);
  }
}
