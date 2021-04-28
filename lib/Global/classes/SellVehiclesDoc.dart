import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class SellVehiclesDoc {

  static const ID = "id";
  static const MODEL = "model";
  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const BRAND = "brand";
  static const SELLAMOUNT = "rent_amount";
  static const SELLERUID = "renter_uid";
  static const SELLERNAME = "renter_name";
  static const SELLERPHONE = "renter_phone";
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
  late double sellAmount;
  late String sellerUID;
  late String sellerName;
  late String sellerPhone;
  late Timestamp createdTimestamp;
  late Timestamp updatedTimestamp;
  late bool isAvailable;
  late bool isActive;
  late GeoHashPoint geoHashPoint;
  late List<dynamic> imageUrls;
  

  SellVehiclesDoc();
  
  SellVehiclesDoc.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.model = snapshot.data()![MODEL];
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.brand = snapshot.data()![BRAND];
    this.sellAmount = snapshot.data()![SELLAMOUNT];
    this.sellerUID = snapshot.data()![SELLERUID];
    this.sellerName = snapshot.data()![SELLERNAME];
    this.sellerPhone = snapshot.data()![SELLERPHONE];
    this.createdTimestamp = snapshot.data()![CREATEDTIMESTAMP];
    this.updatedTimestamp = snapshot.data()![UPDATEDTIMESTAMP];
    this.isAvailable = snapshot.data()![ISAVAILABLE];
    this.isActive = snapshot.data()![ISACTIVE];
    this.geoHashPoint = GeoHashPoint.fromMap(snapshot.data()![LOCATION]);
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  SellVehiclesDoc.newDoc({
    required this.model,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.sellAmount,
    required this.sellerUID,
    required this.sellerName,
    required this.sellerPhone,
    required this.createdTimestamp,
    required this.geoHashPoint,
    this.brand = "",
    this.id = "",
    this.imageUrls = const []
  }) : this.updatedTimestamp = createdTimestamp, this.isAvailable = true, this.isActive = true;
  
  SellVehiclesDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  SellVehiclesDoc.fromIdAndMapData(this.id, Map map) {
    this.model = map[MODEL];
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.brand = map[BRAND];
    this.sellAmount = map[SELLAMOUNT];
    this.sellerUID = map[SELLERUID];
    this.sellerName = map[SELLERNAME];
    this.sellerPhone = map[SELLERPHONE];
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
    SELLAMOUNT : this.sellAmount,
    SELLERUID : this.sellerUID,
    SELLERNAME : this.sellerName,
    SELLERPHONE : this.sellerPhone,
    CREATEDTIMESTAMP : this.createdTimestamp,
    UPDATEDTIMESTAMP : this.updatedTimestamp,
    ISAVAILABLE : this.isAvailable,
    ISACTIVE : this.isActive,
    LOCATION : this.geoHashPoint.toMap(),
    IMAGEURLS : this.imageUrls,
  };

}