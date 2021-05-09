import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseController.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_storage/firebase_storage.dart';



class RentVehiclePageController extends BaseController<RentVehiclesDoc> {

  String? docId;

  RentVehiclePageController([RentVehiclesDoc? item]) {
    if(item!=null) {
      docId = item.id;
      nameC.text = item.title;
      categoryId = item.category;
      brandC.text = item.brand;
      catC.text = toolsCategories[categoryId]!;
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
  TextEditingController brandC = TextEditingController();
  TextEditingController catC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();
  
  List<MapEntry<IMAGESOURCE, String>?> images = [null, null, null, null];
  int? categoryId;
  int durationTypeId = ToolDurationTypes.DAILY;
  
  @override 
  RentVehiclesDoc prepareData([List<String> imgUrls = const []]) {
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    return RentVehiclesDoc.newDoc(
      title: nameC.text.trim(), 
      category: categoryId!, 
      categoryName: categories![categoryId]!,
      desc: descC.text.trim(), 
      rentAmount: double.parse(amountC.text.trim()), 
      rentDurationType: durationTypeId,
      uid: globalUser!.uid,
      brand: brandC.text.trim(),
      uidName: globalUser!.displayName!,
      uidPhone: globalUser!.phoneNumber??"", 
      createdTimestamp: Timestamp.now(),
      geoHashPoint: GeoHashPoint(point.hash, point.geoPoint), 
      id: docId,
      imageUrls: imgUrls,
    );
  }


}