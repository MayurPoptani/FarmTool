import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_storage/firebase_storage.dart';



class RentVehiclePageController {

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

  uploadData(BuildContext context) async {
    print("uploadData");
    if(formKey.currentState!.validate()==false) return;
    showProgressLoaderDialog(context);
    if(images.where((element) => element!=null).isNotEmpty) uploadImages(context);
    else uploadDocument(context);
  }

  uploadImages(BuildContext context) async {
    List<String> ls = [];
    Reference ref = FirebaseStorage.instance.ref().child("RentVehicles");
    List<MapEntry<IMAGESOURCE, String>?> temp = images.where((element) => element!=null).toList();
    String url;
    for(int i = 0 ; i < temp.length ; i++) {
      if(temp[i]!.key==IMAGESOURCE.PATH) {
        print("Uploading Image "+(i+1).toString());
        var task = await ref.child(globalUser!.uid+"-"+DateTime.now().toIso8601String()+"."+temp[i]!.value.trim().split('/').last.split('.').last).putFile(File(temp[i]!.value));
        print(task.state);
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
    RentVehiclesDoc tool =  RentVehiclesDoc.newDoc(
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
      id: "",
      imageUrls: imageUrls,
    );
    
    var docRef;
    if(docId!=null) {
      await FirebaseFirestore.instance.collection("Posts/RentVehicles/Entries").doc(docId).update(tool.toMap());
    } else {
      docRef = await FirebaseFirestore.instance.collection("Posts/RentVehicles/Entries").add(tool.toMap());
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