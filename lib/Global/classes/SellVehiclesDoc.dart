import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class SellVehiclesDoc extends BaseDoc {

  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const BRAND = "brand";
  static const SELLAMOUNT = "rent_amount";
  static const IMAGEURLS = "imgurls";

  bool get isWithoutId => id == "";

  late int category;
  late String categoryName;
  late String desc;
  late String brand;
  late double sellAmount;
  late List<dynamic> imageUrls;
  
  static final SellVehiclesDoc dummyInstance = SellVehiclesDoc.empty();

  SellVehiclesDoc.empty() : super.empty();
  
  SellVehiclesDoc.fromDocument(DocumentSnapshot snapshot) : super.fromDocument(snapshot) {
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.brand = snapshot.data()![BRAND];
    this.sellAmount = snapshot.data()![SELLAMOUNT];
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  SellVehiclesDoc.newDoc({
    required String title,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.sellAmount,
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
  
  SellVehiclesDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  SellVehiclesDoc.fromIdAndMapData(String id, Map map) : super.fromIdAndMapData(id, map) {
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.brand = map[BRAND];
    this.sellAmount = map[SELLAMOUNT];
    this.imageUrls = map[IMAGEURLS];
  }

  Map<String, dynamic> toMap() => {
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    BRAND : this.brand,
    SELLAMOUNT : this.sellAmount,
    IMAGEURLS : this.imageUrls,
    ...super.toMap(),
  };

  @override
  CollectionReference get firebaseColRef => FirebaseFirestore.instance.collection("Posts").doc("SellVehicles").collection("Entries");
  DocumentReference get firebaseDocRef => FirebaseFirestore.instance.collection("Posts").doc("SellVehicles").collection("Entries").doc(id);
  Reference get folderReference => FirebaseStorage.instance.ref("SellVehicles");
}