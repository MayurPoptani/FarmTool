import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:images_picker/images_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SellVehiclePage extends StatefulWidget {
  @override
  _SellVehiclePageState createState() => _SellVehiclePageState();
}

class _SellVehiclePageState extends State<SellVehiclePage> {

  Map<int, String>? categories;
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  TextEditingController catC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  List<String?> images = [null, null, null, null];
  int? categoryId;
  int durationTypeId = ToolDurationTypes.DAILY;

  @override
  void initState() { 
    super.initState();
    fetchRentToolCategories();
  }

  fetchRentToolCategories() async {
    categories = vehiclesCategories;
  }


  @override
  Widget build(BuildContext context) {
    // print(images);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Vehicle", style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black,), 
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("VEHICLE IMAGES"),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12
                        ),
                        padding: EdgeInsets.all(16),
                        child: Builder(
                          builder: (builderContext) => Row(
                            children: images.asMap().entries.map((e) {
                              return Expanded(
                                child: InkWell(
                                  onTap: e.value!=null ? null : () => showImageSelectionOptionsBottomSheet(builderContext, e.key),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width*.175,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: colorBgColor.withOpacity(0.75),
                                    ),
                                    child: e.value==null 
                                      ? Icon(Icons.image_rounded, color: Colors.white,) 
                                      : Stack(
                                        fit: StackFit.expand,
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.file(File(e.value!), fit: BoxFit.fill,),
                                          ),
                                          Positioned(
                                            top: 2, right: 2,
                                            child: InkWell(
                                              onTap: () => setState(() => images[e.key]=null),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: Colors.white
                                                ),
                                                child: Icon(Icons.delete_forever, size: 20, color: Colors.red,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("VEHICLE NAME", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: nameC,
                          validator: (str) {
                            if(str!.trim().isEmpty) return "Please fill the vehicle's name";
                            else return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Name of the vehicle",
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("VEHICLE TYPE", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: DropdownButtonFormField<int>(
                          validator: (str) {
                            if(str==null) return "Please select the vehicle's type";
                            else return null;
                          },
                          hint: Text("Tap to select"),
                          items: (categories??{}).entries.toList().map((e) {
                            return DropdownMenuItem<int>(
                              child: Text(e.value),
                              value: e.key,
                            );
                          }).toList(),
                          value: categoryId,
                          onChanged: (val) => setState(() => categoryId = val??categoryId),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("VEHICLE COMPANY NAME (OPTIONAL)", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: brandC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Example: TATA"
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("SELL AMOUNT", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          validator: (str) {
                            if(str!.trim().isEmpty) return "Please select the vehicle's selling amount";
                            else return null;
                          },
                          controller: amountC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Example: 100"
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("DESCRIPTION (OPTIONAL)", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: descC,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Write something about this vehicle",
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Text("Save", style: TextStyle(color: Colors.white,),),
                        ),
                        onPressed: () => uploadData(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showImageSelectionOptionsBottomSheet(BuildContext childContext, int imageIndex) {
    showModalBottomSheet(context: childContext, builder: (_) => Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_rounded, color: Colors.black,),
                  SizedBox(width: 16,),
                  Expanded(child: Text("Take from Camera", style: TextStyle(fontSize: 16),)),
                ],
              ),
            ),
            onTap: () async {
              List<Media>? image = await ImagesPicker.openCamera(pickType: PickType.image,);
              if(image!=null && image.length>0) images[imageIndex] = image[0].path;
              Navigator.of(_).pop();
              setState(() {});
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.image, color: Colors.black,),
                  SizedBox(width: 16,),
                  Expanded(child: Text("Select from Photos", style: TextStyle(fontSize: 16),)),
                ],
              ),
            ),
            onTap: () async {
              List<Media>? image = await ImagesPicker.pick(pickType: PickType.image,);
              if(image!=null && image.length>0) images[imageIndex] = image[0].path;
              Navigator.of(_).pop();
              setState(() {});
            },
          ),
        ],
      ),
    ),);
    
  }

  uploadData() async {
    if(formKey.currentState!.validate()==false) return;
    List<String> imageUrls = [];
    showProgressLoaderDialog();
    if(images.where((element) => element!=null).isNotEmpty) uploadImages();
    else uploadDocument();
  }


  uploadImages() async {
    List<String> ls = [];
    Reference ref = FirebaseStorage.instance.ref().child("RentTools");
    List<String?> temp = images.where((element) => element!=null).toList();
    for(int i = 0 ; i < temp.length ; i++) {
      var task = await ref.child(globalUser!.uid+"-"+DateTime.now().toIso8601String()+"."+temp[i]!.trim().split('/').last.split('.').last).putFile(File(temp[i]!));
      // TaskSnapshot snap = await task.whenComplete(() {});
      String url = await task.ref.getDownloadURL();
      print("url = "+url);
      ls.add(url);
    }
    uploadDocument(ls);
  }

  uploadDocument([List<String> imageUrls = const []]) async {
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    SellVehiclesDoc vehicle =  SellVehiclesDoc.newDoc(
      model: nameC.text.trim(), 
      category: categoryId!,
      categoryName: categories![categoryId]!,
      desc: descC.text.trim(),
      brand: brandC.text.trim(),
      sellAmount: double.parse(amountC.text.trim()), 
      sellerUID: globalUser!.uid,
      sellerName: globalUser!.displayName!,
      sellerPhone: globalUser!.phoneNumber!,
      createdTimestamp: Timestamp.now(),
      geoHashPoint: GeoHashPoint(point.hash, point.geoPoint),
      imageUrls: imageUrls,
    );

    var docRef = await FirebaseFirestore.instance.collection("SellVehicles").add(vehicle.toMap());
    print(docRef.id);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  void dispose() async {
    DefaultCacheManager().emptyCache().then((value) {
      print("Cache Cleared");
    });
    super.dispose();
  }

  showProgressLoaderDialog() {
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