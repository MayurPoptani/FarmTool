import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class BaseDoc {

  static const ID = "id";
  static const TITLE = "title";
  static const UID = "uid";
  static const UIDNAME = "uid_name";
  static const UIDPHONE = "uid_phone";
  static const CREATEDTIMESTAMP = "created_timestamp";
  static const UPDATEDTIMESTAMP = "updated_timestamp";
  static const ISAVAILABLE = "is_available";
  static const ISACTIVE = "is_active";
  static const LOCATION = "loc";

  late String id;
  late String title;
  late String uid;
  late String uidName;
  late String uidPhone;
  late Timestamp createdTimestamp;
  late Timestamp updatedTimestamp;
  late bool isAvailable;
  late bool isActive;
  late GeoHashPoint geoHashPoint;

  BaseDoc.empty();

  BaseDoc.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    title = doc.data()![TITLE];
    uid = doc.data()![UID];
    uidName = doc.data()![UIDNAME];
    uidPhone = doc.data()![UIDPHONE];
    createdTimestamp = doc.data()![CREATEDTIMESTAMP];
    updatedTimestamp = doc.data()![UPDATEDTIMESTAMP];
    isAvailable = doc.data()![ISAVAILABLE];
    isActive = doc.data()![ISACTIVE];
    geoHashPoint = GeoHashPoint.fromMap(doc.data()![LOCATION]);
  }

  BaseDoc.newDoc({
    this.id = "",
    required this.title,
    required this.uid,
    required this.uidName,
    required this.uidPhone,
    required this.createdTimestamp,
    required this.geoHashPoint,
  }) {
    this.updatedTimestamp = createdTimestamp;
    this.isAvailable = true;
    this.isActive = true;
  }

  BaseDoc.fromIdAndMapData(String id, Map map) {
    id = id;
    title = map[TITLE];
    uid = map[UID];
    uidName = map[UIDNAME];
    uidPhone = map[UIDPHONE];
    createdTimestamp = map[CREATEDTIMESTAMP];
    updatedTimestamp = map[UPDATEDTIMESTAMP];
    isAvailable = map[ISAVAILABLE];
    isActive = map[ISACTIVE];
    geoHashPoint = GeoHashPoint.fromMap(map[LOCATION]);
  }

  Map toMap() => {
    ID : id,
    TITLE : title,
    UID : uid,
    UIDNAME : uidName,
    UIDPHONE : uidPhone,
    CREATEDTIMESTAMP : createdTimestamp,
    UPDATEDTIMESTAMP : updatedTimestamp,
    ISAVAILABLE : isAvailable,
    ISACTIVE : isActive,
    LOCATION : geoHashPoint.toMap(),
  };
}