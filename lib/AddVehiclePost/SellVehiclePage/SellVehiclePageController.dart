import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/BaseController.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_storage/firebase_storage.dart';



class SellVehiclePageController extends BaseController<SellVehiclesDoc> {

  String? docId;

  SellVehiclePageController([SellVehiclesDoc? item]) {
    if(item!=null) {
      docId = item.id;
      nameC.text = item.title;
      categoryId = item.category;
      brandC.text = item.brand;
      catC.text = toolsCategories[categoryId]!;
      amountC.text = item.sellAmount.toString();
      descC.text = item.desc;
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

  int? categoryId;
  List<MapEntry<IMAGESOURCE, String>?> images = [null, null, null, null];

  @override
  SellVehiclesDoc prepareData([List<String> imgUrls = const []]) {
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    return SellVehiclesDoc.newDoc(
      title: nameC.text.trim(), 
      category: categoryId!, 
      brand: brandC.text.trim(),
      categoryName: categories![categoryId]!,
      desc: descC.text.trim(), 
      sellAmount: double.parse(amountC.text.trim()), 
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