import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';

class SellToolsDoc extends BaseDoc {

  static const CATEGORY = "caterogy";
  static const CATEGORYNAME = "caterogy_name";
  static const DESC = "desc";
  static const SELLAMOUNT = "sell_amount";
  static const IMAGEURLS = "imgurls";

  bool get isWithoutId => id == "";

  late int category;
  late String categoryName;
  late String desc;
  late double sellAmount;
  late List<dynamic> imageUrls;
  
  static final SellToolsDoc dummyInstance = SellToolsDoc.empty();

  SellToolsDoc.empty() : super.empty();
  
  SellToolsDoc.fromDocument(DocumentSnapshot snapshot) : super.fromDocument(snapshot) {
    this.category = snapshot.data()![CATEGORY];
    this.categoryName = snapshot.data()![CATEGORYNAME];
    this.desc = snapshot.data()![DESC];
    this.sellAmount = snapshot.data()![SELLAMOUNT];
    this.imageUrls = snapshot.data()![IMAGEURLS];
  }

  SellToolsDoc.newDoc({
    required String title,
    required this.category,
    required this.categoryName,
    required this.desc,
    required this.sellAmount,
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
  
  SellToolsDoc.newDocFromMap(Map map) : this.fromIdAndMapData("", map);
  
  SellToolsDoc.fromIdAndMapData(String id, Map map) : super.fromIdAndMapData(id, map) {
    this.category = map[CATEGORY];
    this.categoryName = map[CATEGORYNAME];
    this.desc = map[DESC];
    this.sellAmount = map[SELLAMOUNT];
    this.imageUrls = map[IMAGEURLS];
  }

  Map<String, dynamic> toMap() => {
    CATEGORY : this.category,
    CATEGORYNAME : this.categoryName,
    DESC : this.desc,
    SELLAMOUNT : this.sellAmount,
    IMAGEURLS : this.imageUrls,
    ...super.toMap(),
  };

  @override
  CollectionReference get firebaseColRef => FirebaseFirestore.instance.collection("Posts").doc("SellTools").collection("Entries");
  DocumentReference get firebaseDocRef => FirebaseFirestore.instance.collection("Posts").doc("SellTools").collection("Entries").doc(id);
  Reference get folderReference => FirebaseStorage.instance.ref("SellTools");
}