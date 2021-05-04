import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class RentWarehousesDoc extends BaseDoc {

  static const IMAGEURLS = "imgurls";
  static const CATEGORY = "caterogy";
  static const LOCATIONTYPE = "location_type";
  static const AREA = "area";
  static const RENTINGTYPE = "renting_type";
  static const RENTAMOUNT = "rent_amount";
  static const RENTDURATIONTYPE = "rent_duration_type";
  static const DESC = "desc";

  bool get isWithoutId => id == "";

  late List<dynamic> imageUrls;
  late int category;
  late int locationType;
  late int area;
  late int rentingType;
  late double rentAmount;
  late int rentDurationType;
  late String desc;
  

  RentWarehousesDoc() : super.empty();
  
  RentWarehousesDoc.fromDocument(DocumentSnapshot snapshot) : super.fromDocument(snapshot) {
    this.imageUrls = snapshot.data()![IMAGEURLS];
    this.category = snapshot.data()![CATEGORY];
    this.locationType = snapshot.data()![LOCATIONTYPE];
    this.area = snapshot.data()![AREA];
    this.rentingType = snapshot.data()![RENTINGTYPE];
    this.rentAmount = snapshot.data()![RENTAMOUNT];
    this.rentDurationType = snapshot.data()![RENTDURATIONTYPE];
    this.desc = snapshot.data()![DESC];
  }

  RentWarehousesDoc.newDoc({
    required String title,
    required String uid,
    required String uidName,
    required String uidPhone,
    required Timestamp createdTimestamp,
    required GeoHashPoint geoHashPoint,
    this.imageUrls = const [],
    required this.category,
    required this.locationType,
    required this.area,
    required this.rentingType,
    required this.rentAmount,
    required this.rentDurationType,
    this.desc = "",
    String? id,
  }) : super.newDoc(
    id: id??"",
    title: title,
    uid: uid,
    uidName: uidName,
    uidPhone: uidPhone,
    createdTimestamp: createdTimestamp,
    geoHashPoint: geoHashPoint
  );
  
  RentWarehousesDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  RentWarehousesDoc.fromIdAndMapData(String id, Map map) : super.fromIdAndMapData(id, map) {
    this.imageUrls = map[IMAGEURLS];
    this.category = map[CATEGORY];
    this.locationType = map[LOCATIONTYPE];
    this.area = map[AREA];
    this.rentingType = map[RENTINGTYPE];
    this.rentAmount = map[RENTAMOUNT];
    this.rentDurationType = map[RENTDURATIONTYPE];
    this.desc = map[DESC];
  }

  Map<String, dynamic> toMap() => {
    IMAGEURLS : this.imageUrls,
    CATEGORY : this.category,
    LOCATIONTYPE : this.locationType,
    AREA : this.area,
    RENTINGTYPE : this.rentingType,
    RENTAMOUNT : this.rentAmount,
    RENTDURATIONTYPE : this.rentDurationType,
    DESC : this.desc,
    ...super.toMap(),
  };

  @override
  CollectionReference get firebaseColRef => FirebaseFirestore.instance.collection("Posts").doc("RentWarehouses").collection("Entries");
  DocumentReference get firebaseDocRef => FirebaseFirestore.instance.collection("Posts").doc("RentWarehouses").collection("Entries").doc(id);
}