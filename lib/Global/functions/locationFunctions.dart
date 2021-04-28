import 'dart:convert';

import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) return Future.error("Location Service Enabled!");
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) return Future.error("Location Permission Not Granted!");
  }
  _locationData = await location.getLocation();
  return _locationData;
}

LocationData? getSavedLocation() {
  String? locDataList = prefs!.getString("location");
  if(locDataList!=null) {
    return LocationData.fromMap((jsonDecode(locDataList) as Map).map<String,double>((key, value) => MapEntry<String,double>(key, value)));
  } 
}

void saveLocation(LocationData loc) {
  prefs!.setString("location", jsonEncode({
    'latitude' : loc.latitude,
    'longitude' : loc.longitude,
    'accuracy' : loc.accuracy,
    'altitude' : loc.altitude,
    'speed' : loc.speed,
    'speed_accuracy' : loc.speedAccuracy,
    'heading' : loc.heading,
    'time' : loc.time,
  }));
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
// Future<Position> getLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the 
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale 
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
  
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately. 
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   } 

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition();
// }

