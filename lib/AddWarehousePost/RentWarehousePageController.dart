import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RentWarehousePageController {

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

  uploadData(BuildContext context) async {
    if(formKey.currentState!.validate()==false) return;
    showProgressLoaderDialog(context);
    if(images.where((element) => element!=null).isNotEmpty) uploadImages(context);
    else uploadDocument(context);
  }

  uploadImages(BuildContext context) async {
    List<String> ls = [];
    Reference ref = FirebaseStorage.instance.ref().child("RentTools");
    List<MapEntry<IMAGESOURCE, String>?> temp = images.where((element) => element!=null).toList();
    String url;
    for(int i = 0 ; i < temp.length ; i++) {
      if(temp[i]!.key==IMAGESOURCE.PATH) {
        var task = await ref.child(globalUser!.uid+"-"+DateTime.now().toIso8601String()+"."+temp[i]!.value.trim().split('/').last.split('.').last).putFile(File(temp[i]!.value));
        url = await task.ref.getDownloadURL();
      } else {
        url = temp[i]!.value;
      }  
      print("url = "+url);
      ls.add(url);
    }
    uploadDocument(context, ls);
  }

  uploadDocument(BuildContext context, [List<String> imageUrls = const []]) async {
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    RentWarehousesDoc tool =  RentWarehousesDoc.newDoc(
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
      id: "",
      imageUrls: imageUrls,
    );
    
    var docRef;
    if(docId!=null) {
      await tool.firebaseDocRef.update(tool.toMap());
    } else {
      docRef = await tool.firebaseColRef.add(tool.toMap());
      print(docRef.id);
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop(true);
  }

  showProgressLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (_) => AlertDialog(
        title: Text("Uploading..."),
        content: Container(
          height: 100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
        ),
      ),
    );
  }

}