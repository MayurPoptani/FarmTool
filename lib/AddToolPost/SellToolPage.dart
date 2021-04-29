import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/SellToolsDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:images_picker/images_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:easy_localization/easy_localization.dart';


class SellToolPage extends StatefulWidget {
  @override
  _SellToolPageState createState() => _SellToolPageState();
}

class _SellToolPageState extends State<SellToolPage> {

  Map<int, String>? categories;
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameC = TextEditingController();
  TextEditingController catC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  List<String?> images = [null, null, null, null];
  int? categoryId;

  @override
  void initState() { 
    super.initState();
    fetchRentToolCategories();
  }

  fetchRentToolCategories() async {
    categories = toolsCategories;
  }


  @override
  Widget build(BuildContext context) {
    // print(images);
    return Scaffold(
      appBar: AppBar(
        title: Text(SELLTOOL.APPBAR_LABEL.tr(), style: TextStyle(color: Colors.black),), 
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
                      Text(SELLTOOL.TOOL_IMAGES.tr()),
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
                      Text(SELLTOOL.TOOL_NAME.tr(), style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: nameC,
                          validator: (str) {
                            if(str!.trim().isEmpty) return SELLTOOL.TOOL_NAME_EMPTY_ERROR.tr();
                            else return null;
                          },
                          decoration: InputDecoration(
                            hintText: SELLTOOL.TOOL_NAME_LABEL.tr(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(SELLTOOL.TOOL_TYPE.tr(), style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: DropdownButtonFormField<int>(
                          validator: (str) {
                            if(str==null) return SELLTOOL.TOOL_TYPE_EMPTY_ERROR.tr();
                            else return null;
                          },
                          hint: Text(SELLTOOL.TOOL_TYPE_LABEL.tr()),
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
                      Text(SELLTOOL.SELL_AMOUNT.tr(), style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          validator: (str) {
                            if(str!.trim().isEmpty) return SELLTOOL.TOOL_SELL_AMOUT_EMPTY_ERROR.tr();
                            else return null;
                          },
                          controller: amountC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: SELLTOOL.SELL_AMOUNT_LABEL.tr()
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(SELLTOOL.DESCRIPTION.tr(), style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: descC,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: SELLTOOL.DESCRIPTION_LABEL.tr(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Text(SELLTOOL.SAVE.tr(), style: TextStyle(color: Colors.white,),),
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
    Reference ref = FirebaseStorage.instance.ref().child("SellTools");
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
    SellToolsDoc tool =  SellToolsDoc.newDoc(
      title: nameC.text.trim(), 
      category: categoryId!, 
      categoryName: categories![categoryId]!,
      desc: descC.text.trim(), 
      sellAmount: double.parse(amountC.text.trim()), 
      sellerUID: globalUser!.uid, 
      renterName: globalUser!.displayName!,
      renterPhone: globalUser!.phoneNumber!,
      createdTimestamp: Timestamp.now(),
      geoHashPoint: GeoHashPoint(point.hash, point.geoPoint), 
      id: "",
      imageUrls: imageUrls,
    );

    var docRef = await FirebaseFirestore.instance.collection("Posts/SellTools/Entries").add(tool.toMap());
    print(docRef.id);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
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

  @override
  void dispose() async {
    DefaultCacheManager().emptyCache().then((value) {
      print("Cache Cleared");
    });
    super.dispose();
  }

}