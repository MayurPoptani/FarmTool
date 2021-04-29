import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class RentVehiclesDoc {

  static const ID = "id";
  static const MODEL = "model";
  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const BRAND = "brand";
  static const RENTAMOUNT = "rent_amount";
  static const RENTDURATIONTYPE = "rent_duration_type";
  static const RENTERUID = "uid";
  static const RENTERNAME = "uid_name";
  static const RENTERPHONE = "renter_phone";
  static const CREATEDTIMESTAMP = "created_timestamp";
  static const UPDATEDTIMESTAMP = "updated_timestamp";
  static const ISAVAILABLE = "is_available";
  static const ISACTIVE = "is_active";
  static const LOCATION = "loc";
  static const IMAGEURLS = "imgurls";

  bool get isWithoutId => id == "";

  late String id;
  late String model;
  late int category;
  late String categoryName;
  late String desc;
  late String brand;
  late double rentAmount;
  late int rentDurationType;
  late String renterUID;
  late String renterName;
  late String renterPhone;
  late Timestamp createdTimestamp;
  late Timestamp updatedTimestamp;
  late bool isAvailable;
  late bool isActive;
  late GeoHashPoint geoHashPoint;
  late List<dynamic> imageUrls;
  

  RentVehiclesDoc();
  
  RentVehiclesDoc.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.model = snapshot.data()![MODEL];
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.brand = snapshot.data()![BRAND];
    this.rentAmount = snapshot.data()![RENTAMOUNT];
    this.rentDurationType = snapshot.data()![RENTDURATIONTYPE];
    this.renterUID = snapshot.data()![RENTERUID];
    this.renterName = snapshot.data()![RENTERNAME];
    this.renterPhone = snapshot.data()![RENTERPHONE];
    this.createdTimestamp = snapshot.data()![CREATEDTIMESTAMP];
    this.updatedTimestamp = snapshot.data()![UPDATEDTIMESTAMP];
    this.isAvailable = snapshot.data()![ISAVAILABLE];
    this.isActive = snapshot.data()![ISACTIVE];
    this.geoHashPoint = GeoHashPoint.fromMap(snapshot.data()![LOCATION]);
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  RentVehiclesDoc.newDoc({
    required this.model,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.rentAmount,
    required this.rentDurationType,
    required this.renterUID,
    required this.renterName,
    required this.renterPhone,
    required this.createdTimestamp,
    required this.geoHashPoint,
    this.brand = "",
    this.id = "",
    this.imageUrls = const []
  }) : this.updatedTimestamp = createdTimestamp, this.isAvailable = true, this.isActive = true;
  
  RentVehiclesDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  RentVehiclesDoc.fromIdAndMapData(this.id, Map map) {
    this.model = map[MODEL];
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.brand = map[BRAND];
    this.rentAmount = map[RENTAMOUNT];
    this.rentDurationType = map[RENTDURATIONTYPE];
    this.renterUID = map[RENTERUID];
    this.renterName = map[RENTERNAME];
    this.renterPhone = map[RENTERPHONE];
    this.createdTimestamp = map[CREATEDTIMESTAMP];
    this.updatedTimestamp = map[UPDATEDTIMESTAMP];
    this.isAvailable = map[ISAVAILABLE];
    this.isActive = map[ISACTIVE];
    this.geoHashPoint = GeoHashPoint.fromMap(map[LOCATION]);
    this.imageUrls = map[IMAGEURLS];
  }

  Map<String, dynamic> toMap() => {
    ID : id,
    MODEL : this.model,
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    BRAND : this.brand,
    RENTAMOUNT : this.rentAmount,
    RENTDURATIONTYPE : this.rentDurationType,
    RENTERUID : this.renterUID,
    RENTERNAME : this.renterName,
    RENTERPHONE : this.renterPhone,
    CREATEDTIMESTAMP : this.createdTimestamp,
    UPDATEDTIMESTAMP : this.updatedTimestamp,
    ISAVAILABLE : this.isAvailable,
    ISACTIVE : this.isActive,
    LOCATION : this.geoHashPoint.toMap(),
    IMAGEURLS : this.imageUrls,
  };

}