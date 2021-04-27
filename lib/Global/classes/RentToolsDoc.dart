import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class RentToolsDoc {

  static const ID = "id";
  static const TITLE = "title";
  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const RENTAMOUNT = "rent_amount";
  static const RENTDURATIONTYPE = "rent_duration_type";
  static const RENTERUID = "renter_uid";
  static const CREATEDTIMESTAMP = "created_timestamp";
  static const UPDATEDTIMESTAMP = "updated_timestamp";
  static const ISAVAILABLE = "is_available";
  static const ISACTIVE = "is_active";
  static const LOCATION = "loc";
  static const IMAGEURLS = "imgurls";

  bool get isWithoutId => id == "";

  late String id;
  late String title;
  late int category;
  late String categoryName;
  late String desc;
  late double rentAmount;
  late int rentDurationType;
  late String renterUID;
  late Timestamp createdTimestamp;
  late Timestamp updatedTimestamp;
  late bool isAvailable;
  late bool isActive;
  late GeoHashPoint geoHashPoint;
  late List<dynamic> imageUrls;
  

  RentToolsDoc();
  
  RentToolsDoc.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.title = snapshot.data()![TITLE];
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.rentAmount = snapshot.data()![RENTAMOUNT];
    this.rentDurationType = snapshot.data()![RENTDURATIONTYPE];
    this.renterUID = snapshot.data()![RENTERUID];
    this.createdTimestamp = snapshot.data()![CREATEDTIMESTAMP];
    this.updatedTimestamp = snapshot.data()![UPDATEDTIMESTAMP];
    this.isAvailable = snapshot.data()![ISAVAILABLE];
    this.isActive = snapshot.data()![ISACTIVE];
    this.geoHashPoint = GeoHashPoint.fromMap(snapshot.data()![LOCATION]);
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  RentToolsDoc.newDoc({
    required this.title,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.rentAmount,
    required this.rentDurationType,
    required this.renterUID,
    required this.createdTimestamp,
    required this.id,
    required this.geoHashPoint,
    this.imageUrls = const []
  }) : this.updatedTimestamp = createdTimestamp, this.isAvailable = true, this.isActive = true;
  
  RentToolsDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  RentToolsDoc.fromIdAndMapData(this.id, Map map) {
    this.title = map[TITLE];
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.rentAmount = map[RENTAMOUNT];
    this.rentDurationType = map[RENTDURATIONTYPE];
    this.renterUID = map[RENTERUID];
    this.createdTimestamp = map[CREATEDTIMESTAMP];
    this.updatedTimestamp = map[UPDATEDTIMESTAMP];
    this.isAvailable = map[ISAVAILABLE];
    this.isActive = map[ISACTIVE];
    this.geoHashPoint = GeoHashPoint.fromMap(map[LOCATION]);
    this.imageUrls = map[IMAGEURLS];
  }

  Map<String, dynamic> toMap() => {
    ID : id,
    TITLE : this.title,
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    RENTAMOUNT : this.rentAmount,
    RENTDURATIONTYPE : this.rentDurationType,
    RENTERUID : this.renterUID,
    CREATEDTIMESTAMP : this.createdTimestamp,
    UPDATEDTIMESTAMP : this.updatedTimestamp,
    ISAVAILABLE : this.isAvailable,
    ISACTIVE : this.isActive,
    LOCATION : this.geoHashPoint.toMap(),
    IMAGEURLS : this.imageUrls,
  };

}