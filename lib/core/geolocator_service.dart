import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';


import 'http_service.dart';

class GeolocatorService {
  static bool _serviceEnabled = false;
  static LocationPermission? _permissionGranted;
 //static Location location = Location();

  static Future<Position?>
      checkLocationServicesInDevice() async {
    print('GeolocatorService checkLocationServicesInDevice');
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (_serviceEnabled) {
      return checkLocationPermission();
    } else {
      return checkLocationPermission();
      /*  _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        return checkLocationPermission();
      } else {
        return Left(LocationServiceFailure());
      }*/
    }
  }

  static Future<Position?> checkLocationPermission() async {
    print('GeolocatorService checkLocationPermission');
    _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted != LocationPermission.denied &&
        _permissionGranted != LocationPermission.deniedForever) {
      return await getCurrentLocation();
    } else {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted != LocationPermission.denied &&
          _permissionGranted != LocationPermission.deniedForever) {
        return await getCurrentLocation();
      } else {
        return null;
      }
    }
  }

  static Future<Position?> getCurrentLocation() async {
    print('GeolocatorService getCurrentLocation');
    //  LocationData locationData = await location.getLocation();
    Position position = await Geolocator.getCurrentPosition();
    print(
        'GeolocatorService getCurrentLocation ${position.longitude} ${position.latitude}');

    return position;
  }

}
