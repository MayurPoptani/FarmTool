import 'package:cloud_firestore/cloud_firestore.dart';

class GeoHashPoint {

  static const String GEOHASH = "geohash";
  static const String GEOPOINT = "geopoint";  

  late GeoPoint geoPoint;
  late String geoHash;
  GeoHashPoint(this.geoHash, this.geoPoint);
  GeoHashPoint.fromMap(Map data) {
    this.geoHash = data[GEOHASH] as String;
    this.geoPoint = data[GEOPOINT] as GeoPoint;
  }

  Map<String, dynamic> toMap() => {
    GEOHASH : geoHash,
    GEOPOINT : geoPoint,
  };
}