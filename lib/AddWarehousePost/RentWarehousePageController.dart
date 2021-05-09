import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseController.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RentWarehousePageController extends BaseController<RentWarehousesDoc> {

  String? docId;

  RentWarehousePageController([RentWarehousesDoc? item]) {
    if(item!=null) {
      docId = item.id;
      nameC.text = item.title;
      areaC.text = item.area.toStringAsFixed(0);
      category = item.category;
      rentingType = item.rentingType;
      locationType = item.locationType;
      amountC.text = item.rentAmount.toString();
      descC.text = item.desc;
      durationTypeId = item.rentDurationType;
      for(int i = 0 ; i < item.imageUrls.length ; i++) {
        images[i] = MapEntry(IMAGESOURCE.URL, item.imageUrls[i]);
      }
    }
  }

  Map<int, String>? categories;
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController areaC = TextEditingController();
  late int rentingType = warehousesRentCategories.entries.first.key;
  late int category = warehousesCategories.entries.first.key;
  late int locationType = warehousesLocationTypes.entries.first.key;
  

  List<MapEntry<IMAGESOURCE, String>?> images = [null, null, null, null];
  int durationTypeId = WarehouseDurationTypes.DAILY;

  @override 
  RentWarehousesDoc prepareData([List<String> imgUrls = const []]) {
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    return RentWarehousesDoc.newDoc(
      title: nameC.text.trim(),
      area: int.parse(areaC.text.trim()),
      rentingType: rentingType,
      category: category,
      locationType: locationType, 
      desc: descC.text.trim(), 
      rentAmount: double.parse(amountC.text.trim()), 
      rentDurationType: durationTypeId,
      uid: globalUser!.uid,
      uidName: globalUser!.displayName!,
      uidPhone: globalUser!.phoneNumber??"", 
      createdTimestamp: Timestamp.now(),
      geoHashPoint: GeoHashPoint(point.hash, point.geoPoint), 
      id: docId,
      imageUrls: imgUrls,
    );
  }


}