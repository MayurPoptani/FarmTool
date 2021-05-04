import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/LaborsDoc.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_storage/firebase_storage.dart';



class AddLaborPageController {

  String? docId = "";

  AddLaborPageController([LaborsDoc? item]) {
    if(item!=null) {
      docId = item.id;
      categoryId = item.category;
      catC.text = toolsCategories[categoryId]!;
      amountC.text = item.wageAmount.toString();
      descC.text = item.desc;
      durationTypeId = item.wageDurationType;
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amountC = TextEditingController();
  TextEditingController catC = TextEditingController();
  TextEditingController descC = TextEditingController();
  int categoryId = laborsCategoriesWithAllAsEntry.entries.first.key;

  Map<int,String>? categories;
  
  int durationTypeId = ToolDurationTypes.DAILY;

  uploadData(BuildContext context) async {
    if(formKey.currentState!.validate()==false) return;
    showProgressLoaderDialog(context);
    uploadDocument(context);
  }

  uploadDocument(BuildContext context, [List<String> imageUrls = const []]) async {
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    LaborsDoc tool =  LaborsDoc.newDoc(
      title: "",
      category: categoryId, 
      desc: descC.text.trim(), 
      wageAmount: double.parse(amountC.text.trim()), 
      wageDurationType: durationTypeId,
      uid: globalUser!.uid,
      uidName: globalUser!.displayName!,
      uidPhone: globalUser!.phoneNumber??"", 
      createdTimestamp: Timestamp.now(),
      geoHashPoint: GeoHashPoint(point.hash, point.geoPoint), 
      id: docId,
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