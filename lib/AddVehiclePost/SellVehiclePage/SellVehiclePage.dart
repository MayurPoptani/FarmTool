import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/AddVehiclePost/SellVehiclePage/SellVehiclePageController.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/functions/ExtendedImageFunctions.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:images_picker/images_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SellVehiclePage extends StatefulWidget {

  final bool isEdit;
  final SellVehiclesDoc item;
  SellVehiclePage() : this.item = SellVehiclesDoc(), this.isEdit = false;
  SellVehiclePage.edit(this.item) : this.isEdit = true;

  @override
  _SellVehiclePageState createState() => _SellVehiclePageState();
}

class _SellVehiclePageState extends State<SellVehiclePage> {

  late final SellVehiclePageController c;

  @override
  void initState() { 
    c = SellVehiclePageController(widget.isEdit ? widget.item : null);
    super.initState();
    fetchRentToolCategories();
  }

  fetchRentToolCategories() async {
    c.categories = vehiclesCategories;
  }


  @override
  Widget build(BuildContext context) {
    // print(images);
    return Scaffold(
      appBar: AppBar(
        title: Text(SELLVEHICLE.APPBAR_LABEL, style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black,), 
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: c.formKey,
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
                        child: Text(SELLVEHICLE.VEHICLE_IMAGES),
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
                            children: c.images.asMap().entries.map((e) {
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
                                            child: e.value!.key == IMAGESOURCE.PATH 
                                              ? ExtendedImage.file(
                                                File(e.value!.value), 
                                                fit: BoxFit.fill,
                                                loadStateChanged: extendedImageStateBuilder,
                                              ): ExtendedImage.network(
                                                e.value!.value, 
                                                fit: BoxFit.fill,
                                                timeLimit: Duration(seconds: 5),
                                                loadStateChanged: extendedImageStateBuilder,
                                              )
                                          ),
                                          Positioned(
                                            top: 2, right: 2,
                                            child: InkWell(
                                              onTap: () => setState(() => c.images[e.key]=null),
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
                      Text(SELLVEHICLE.VEHICLE_NAME, style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: c.nameC,
                          validator: (str) {
                            if(str!.trim().isEmpty) return SELLVEHICLE.VEHICLE_NAME_EMPTY_ERROR;
                            else return null;
                          },
                          decoration: InputDecoration(
                            hintText: SELLVEHICLE.VEHICLE_NAME_LABEL,
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(SELLVEHICLE.VEHICLE_TYPE, style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: DropdownButtonFormField<int>(
                          validator: (str) {
                            if(str==null) return SELLVEHICLE.VEHICLE_TYPE_EMPTY_ERROR;
                            else return null;
                          },
                          hint: Text(SELLVEHICLE.VEHICLE_TYPE_LABEL),
                          items: (c.categories??{}).entries.toList().map((e) {
                            return DropdownMenuItem<int>(
                              child: Text(e.value),
                              value: e.key,
                            );
                          }).toList(),
                          value: c.categoryId,
                          onChanged: (val) => setState(() => c.categoryId = val??c.categoryId),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(SELLVEHICLE.VEHICLE_COMPANY, style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: c.brandC,
                          decoration: InputDecoration(
                            hintText: SELLVEHICLE.VEHICLE_COMPANY_LABEL
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(SELLVEHICLE.SELL_AMOUNT, style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          validator: (str) {
                            if(str!.trim().isEmpty) return SELLVEHICLE.VEHICLE_SELL_AMOUNT_EMPTY_ERROR;
                            else return null;
                          },
                          controller: c.amountC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: SELLVEHICLE.SELL_AMOUNT_LABEL
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(SELLVEHICLE.DESCRIPTION, style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: c.descC,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: SELLVEHICLE.DESCRIPTION_LABEL,
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Text(SELLVEHICLE.SAVE, style: TextStyle(color: Colors.white,),),
                        ),
                        onPressed: () => c.uploadData(context),
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
              if(image!=null && image.length>0) c.images[imageIndex] = MapEntry(IMAGESOURCE.PATH, image[0].path!);
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
              if(image!=null && image.length>0) c.images[imageIndex] = MapEntry(IMAGESOURCE.PATH, image[0].path!);
              Navigator.of(_).pop();
              setState(() {});
            },
          ),
        ],
      ),
    ),);
  }

  @override
  void dispose() async {
    DefaultCacheManager().emptyCache().then((value) {
      print("Cache Cleared");
    });
    super.dispose();
  }

}