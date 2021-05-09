import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class RentVehiclesDoc extends BaseDoc {

  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const BRAND = "brand";
  static const RENTAMOUNT = "rent_amount";
  static const RENTDURATIONTYPE = "rent_duration_type";
  static const IMAGEURLS = "imgurls";

  bool get isWithoutId => id == "";

  late int category;
  late String categoryName;
  late String desc;
  late String brand;
  late double rentAmount;
  late int rentDurationType;
  late List<dynamic> imageUrls;
  
  static final RentVehiclesDoc dummyInstance = RentVehiclesDoc.empty();

  RentVehiclesDoc.empty() : super.empty();
  
  RentVehiclesDoc.fromDocument(DocumentSnapshot snapshot) : super.fromDocument(snapshot) {
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.brand = snapshot.data()![BRAND];
    this.rentAmount = snapshot.data()![RENTAMOUNT];
    this.rentDurationType = snapshot.data()![RENTDURATIONTYPE];
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  RentVehiclesDoc.newDoc({
    required String title,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.rentAmount,
    required this.rentDurationType,
    this.brand = "",
    required String uid,
    required String uidName,
    required String uidPhone,
    required Timestamp createdTimestamp,
    required GeoHashPoint geoHashPoint,
    this.imageUrls = const [],
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
  
  RentVehiclesDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  RentVehiclesDoc.fromIdAndMapData(String id, Map map) : super.fromIdAndMapData(id, map) {
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.brand = map[BRAND];
    this.rentAmount = map[RENTAMOUNT];
    this.rentDurationType = map[RENTDURATIONTYPE];
    this.imageUrls = map[IMAGEURLS];
  }

  Map<String, dynamic> toMap() => {
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    BRAND : this.brand,
    RENTAMOUNT : this.rentAmount,
    RENTDURATIONTYPE : this.rentDurationType,
    IMAGEURLS : this.imageUrls,
    ...super.toMap(),
  };

  @override
  CollectionReference get firebaseColRef => FirebaseFirestore.instance.collection("Posts").doc("RentVehicles").collection("Entries");
  DocumentReference get firebaseDocRef => FirebaseFirestore.instance.collection("Posts").doc("RentVehicles").collection("Entries").doc(id);
  Reference get folderReference => FirebaseStorage.instance.ref("RentVehicles");
}