import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class RentToolsDoc extends BaseDoc {

  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const RENTAMOUNT = "rent_amount";
  static const RENTDURATIONTYPE = "rent_duration_type";
  static const IMAGEURLS = "imgurls";

  bool get isWithoutId => id == "";

  late int category;
  late String categoryName;
  late String desc;
  late double rentAmount;
  late int rentDurationType;
  late List<dynamic> imageUrls;
  

  RentToolsDoc.empty() : super.empty();
  
  RentToolsDoc.fromDocument(DocumentSnapshot snapshot) : super.fromDocument(snapshot) {
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.rentAmount = snapshot.data()![RENTAMOUNT];
    this.rentDurationType = snapshot.data()![RENTDURATIONTYPE];
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  RentToolsDoc.newDoc({
    required String title,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.rentAmount,
    required this.rentDurationType,
    required String uid,
    required String uidName,
    required String uidPhone,
    required Timestamp createdTimestamp,
    required String? id,
    required GeoHashPoint geoHashPoint,
    this.imageUrls = const []
  }) : super.newDoc(
    id: id??"",
    title: title,
    uid: uid,
    uidName: uidName,
    uidPhone: uidPhone,
    createdTimestamp: createdTimestamp,
    geoHashPoint: geoHashPoint
  );
  
  RentToolsDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  RentToolsDoc.fromIdAndMapData(String id, Map map) : super.fromIdAndMapData(id, map) {
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.rentAmount = map[RENTAMOUNT];
    this.rentDurationType = map[RENTDURATIONTYPE];
    this.imageUrls = map[IMAGEURLS];
  }

  Map<String, dynamic> toMap() => {
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    RENTAMOUNT : this.rentAmount,
    RENTDURATIONTYPE : this.rentDurationType,
    IMAGEURLS : this.imageUrls,
    ...super.toMap(),
  };

  @override
  CollectionReference get firebaseColRef => FirebaseFirestore.instance.collection("Posts").doc("RentTools").collection("Entries");
  DocumentReference get firebaseDocRef => FirebaseFirestore.instance.collection("Posts").doc("RentTools").collection("Entries").doc(id);
}