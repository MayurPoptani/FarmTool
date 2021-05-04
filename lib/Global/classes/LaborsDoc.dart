import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class LaborsDoc extends BaseDoc {

  static const CATEGORY = "caterogy";
  static const DESC = "desc";
  static const RENTAMOUNT = "labor_amount";
  static const RENTDURATIONTYPE = "labor_duration_type";

  bool get isWithoutId => id == "";

  late int category;
  late String desc;
  late double wageAmount;
  late int wageDurationType;
  

  LaborsDoc.empty() : super.empty();
  
  LaborsDoc.fromDocument(DocumentSnapshot snapshot) : super.fromDocument(snapshot) {
    this.category = snapshot.data()![CATEGORY];
    this.desc = snapshot.data()![DESC];
    this.wageAmount = snapshot.data()![RENTAMOUNT];
    this.wageDurationType = snapshot.data()![RENTDURATIONTYPE];
  }

  LaborsDoc.newDoc({
    required String title,
    required this.category,
    required this.desc,
    required this.wageAmount,
    required this.wageDurationType,
    required String uid,
    required String uidName,
    required String uidPhone,
    required Timestamp createdTimestamp,
    required String? id,
    required GeoHashPoint geoHashPoint,
  }) : super.newDoc(
    id: id??"",
    title: title,
    uid: uid,
    uidName: uidName,
    uidPhone: uidPhone,
    createdTimestamp: createdTimestamp,
    geoHashPoint: geoHashPoint
  );
  
  LaborsDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  LaborsDoc.fromIdAndMapData(String id, Map map) : super.fromIdAndMapData(id, map) {
    this.category = map[CATEGORY];
    this.desc = map[DESC];
    this.wageAmount = map[RENTAMOUNT];
    this.wageDurationType = map[RENTDURATIONTYPE];
  }

  Map<String, dynamic> toMap() => {
    CATEGORY : this.category,
    DESC : this.desc,
    RENTAMOUNT : this.wageAmount,
    RENTDURATIONTYPE : this.wageDurationType,
    ...super.toMap(),
  };

  @override
  CollectionReference get firebaseColRef => FirebaseFirestore.instance.collection("Posts").doc("Labors").collection("Entries");
  DocumentReference get firebaseDocRef => FirebaseFirestore.instance.collection("Posts").doc("Labors").collection("Entries").doc(id);
}