import 'package:cloud_firestore/cloud_firestore.dart';

class ToolsDoc {

  static const ID = "id";
  static const TITLE = "title";
  static const CATEGORY = "caterogy";
  static const DESC = "desc";
  static const RENTAMOUNT = "rent_amount";
  static const RENTDURATIONTYPE = "rent_duration_type";
  static const RENTERUID = "renter_uid";
  static const CREATEDTIMESTAMP = "created_timestamp";
  static const UPDATEDTIMESTAMP = "updated_timestamp";
  static const ISAVAILABLE = "is_available";
  static const ISACTIVE = "is_active";

  bool get isWithoutId => id == "";

  late String id;
  late String title;
  late String category;
  late String desc;
  late double rentAmount;
  late int rentDurationType;
  late String renterUID;
  late Timestamp createdTimestamp;
  late Timestamp updatedTimestamp;
  late bool isAvailable;
  late bool isActive;

  ToolsDoc();
  
  ToolsDoc.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.id;
    this.title = snapshot.data()![TITLE];
    this.category = snapshot.data()![CATEGORY];
    this.desc = snapshot.data()![DESC];
    this.rentAmount = snapshot.data()![RENTAMOUNT];
    this.rentDurationType = snapshot.data()![RENTDURATIONTYPE];
    this.renterUID = snapshot.data()![RENTERUID];
    this.createdTimestamp = snapshot.data()![CREATEDTIMESTAMP];
    this.updatedTimestamp = snapshot.data()![UPDATEDTIMESTAMP];
    this.isAvailable = snapshot.data()![ISAVAILABLE];
    this.isActive = snapshot.data()![ISACTIVE];
  }

  ToolsDoc.newDoc({
    required this.title,
    required this.category,
    required this.desc,
    required this.rentAmount,
    required this.rentDurationType,
    required this.renterUID,
    required this.createdTimestamp,
    required this.id,
  }) : this.updatedTimestamp = createdTimestamp, this.isAvailable = true, this.isActive = true;
  
  ToolsDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  ToolsDoc.fromIdAndMapData(this.id, Map map) {
    this.title = map[TITLE];
    this.category = map[CATEGORY];
    this.desc = map[DESC];
    this.rentAmount = map[RENTAMOUNT];
    this.rentDurationType = map[RENTDURATIONTYPE];
    this.renterUID = map[RENTERUID];
    this.createdTimestamp = map[CREATEDTIMESTAMP];
    this.updatedTimestamp = map[UPDATEDTIMESTAMP];
    this.isAvailable = map[ISAVAILABLE];
    this.isActive = map[ISACTIVE];
  }

  Map<String, dynamic> toMap() => {
    ID : id,
    TITLE : this.title,
    CATEGORY : this.category,
    DESC : this.desc,
    RENTAMOUNT : this.rentAmount,
    RENTDURATIONTYPE : this.rentDurationType,
    RENTERUID : this.renterUID,
    CREATEDTIMESTAMP : this.createdTimestamp,
    UPDATEDTIMESTAMP : this.updatedTimestamp,
    ISAVAILABLE : this.isAvailable,
    ISACTIVE : this.isActive,
  };

}