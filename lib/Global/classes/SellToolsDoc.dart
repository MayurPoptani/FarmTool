import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class SellToolsDoc {

  static const ID = "id";
  static const TITLE = "title";
  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const SELLAMOUNT = "sell_amount";
  static const SELLERUID = "uid";
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
  late String title;
  late int category;
  late String categoryName;
  late String desc;
  late double sellAmount;
  late String sellerUID;
  late String renterName;
  late String renterPhone;
  late Timestamp createdTimestamp;
  late Timestamp updatedTimestamp;
  late bool isAvailable;
  late bool isActive;
  late GeoHashPoint geoHashPoint;
  late List<dynamic> imageUrls;
  

  SellToolsDoc();
  
  SellToolsDoc.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.title = snapshot.data()![TITLE];
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.sellAmount = snapshot.data()![SELLAMOUNT];
    this.sellerUID = snapshot.data()![SELLERUID];
    this.renterName = snapshot.data()![RENTERNAME];
    this.renterPhone = snapshot.data()![RENTERPHONE];
    this.createdTimestamp = snapshot.data()![CREATEDTIMESTAMP];
    this.updatedTimestamp = snapshot.data()![UPDATEDTIMESTAMP];
    this.isAvailable = snapshot.data()![ISAVAILABLE];
    this.isActive = snapshot.data()![ISACTIVE];
    this.geoHashPoint = GeoHashPoint.fromMap(snapshot.data()![LOCATION]);
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  SellToolsDoc.newDoc({
    required this.title,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.sellAmount,
    required this.sellerUID,
    required this.renterName,
    required this.renterPhone,
    required this.createdTimestamp,
    required this.id,
    required this.geoHashPoint,
    this.imageUrls = const []
  }) : this.updatedTimestamp = createdTimestamp, this.isAvailable = true, this.isActive = true;
  
  SellToolsDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  SellToolsDoc.fromIdAndMapData(this.id, Map map) {
    this.title = map[TITLE];
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.sellAmount = map[SELLAMOUNT];
    this.sellerUID = map[SELLERUID];
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
    TITLE : this.title,
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    SELLAMOUNT : this.sellAmount,
    SELLERUID : this.sellerUID,
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