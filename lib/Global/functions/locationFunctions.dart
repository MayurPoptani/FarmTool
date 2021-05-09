import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

// Future<LocationData> getLocation() async {
//   Location location = new Location();
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;
//   print("location.serviceEnabled()");
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     print("FALSE => location.requestService()");
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) return Future.error("Location Service Enabled!");
//   }
//   print("TRUE => location.hasPermission()");
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     print("PermissionStatus.denied => location.requestPermission()");
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) return Future.error("Location Permission Not Granted!");
//   }
//   _locationData = await location.getLocation();
//   return _locationData;
// }

Position? getSavedLocation() {
  // prefs!.clear();
  String? locDataList = prefs!.getString("location");
  if(locDataList!=null) {
    // print(locDataList);
    return Position.fromMap((jsonDecode(locDataList) as Map)
      .map<String,dynamic>((key, value) {
        if(key!="timestamp") return MapEntry<String,double>(key, value);
        else return MapEntry(key, DateTime.parse(value));
      }));
  } 
}

void saveLocation(Position pos) {
  prefs!.setString("location", jsonEncode(<String,dynamic>{
    'accuracy' :  pos.accuracy,
    'altitude' :  pos.altitude,
    'latitude' :  pos.latitude,
    'longitude' :  pos.longitude,
    'heading' :  pos.heading,
    'speed' :  pos.speed,
    'speedAccuracy' :  pos.speedAccuracy,
    'floor' :  pos.floor,
    // 'timestamp' :  pos.timestamp!.toIso8601String(),
    // "isMocked" : pos.isMocked,
  }));
}

// Determine the current position of the device.
// When the location services are not enabled or permissions
// are denied the `Future` will return an error.
Future<Position> getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  serviceEnabled = await Location().serviceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    serviceEnabled = await Location().requestService();
    if (!serviceEnabled) return Future.error("Location Service Enabled!");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Stream<Position> getLocationStream() {
  return (Geolocator.getPositionStream()..listen((event) => saveLocation(event)));
}

double getDistanceBetween(GeoPoint a, GeoPoint b) {
  return GeoFirePoint.distanceBetween(to: Coordinates(a.latitude, a.longitude), from: Coordinates(b.latitude, b.longitude));
}



GeoPoint geoPointFromPosition(Position pos) {
  return GeoPoint(pos.latitude, pos.longitude);
}
