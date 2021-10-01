import 'package:function_app/Services/LocationServices.dart';
import 'package:test/test.dart';

void main() {
  compareObject(obj1, obj2) {
    return identical(obj1, obj2);
  }

  group('Location Services', () {
    test(' getDistance : calculate distance between two coordinates', () {
      final locationDistance =
          LocationService.getDistance(6.9271, 79.8612, 5.9549, 80.5550);
      expect(locationDistance, 132674.0);
    });
    test(
        ' getDistance : must return 0.0 when coordinates exceeds standards values',
        () {
      final locationDistance =
          LocationService.getDistance(288, 79.8612, 5.9549, 80.5550);
      expect(locationDistance, 0.0);
    });
  });
}
