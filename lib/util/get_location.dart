import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sales_app/util/connection.dart';

class GetLocation {
  Future<List<dynamic>> getLocation() async {
    Position currentLocation;
    var coordinate = [];
    final Connection checkConnection = Connection();

    try {
      final bool connect = await checkConnection.initConnectivity();
      if (connect) {
        currentLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        coordinate.add(currentLocation.latitude.toString());
        coordinate.add(currentLocation.longitude.toString());

        return coordinate;
      } else {
        return coordinate;
      }
    } catch (error) {
      print(error);
      return coordinate;
    }
  }

  Future<double> distanceToKM(
      double lat1, double lng1, double lat2, double lng2) async {
    double result = Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
    double distanceInKiloMeters = result / 1000;
    double roundDistanceInKM =
        double.parse((distanceInKiloMeters).toStringAsFixed(3));
    return roundDistanceInKM;
  }
}
