import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/AddLaborPost/AddLaborPostController.dart';
import 'package:farmtool/AddToolPost/RentToolPage/RentToolPageController.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/LaborsDoc.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/functions/Dialogs.dart';
import 'package:farmtool/Global/functions/ExtendedImageFunctions.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/Global/variables/enums.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:images_picker/images_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:farmtool/Global/widgets/MyExtentions.dart';

class AddLaborPage extends StatefulWidget {

  final bool isEdit;
  final LaborsDoc item;
  AddLaborPage() : this.item = LaborsDoc.empty(), this.isEdit = false;
  AddLaborPage.edit(this.item) : this.isEdit = true;

  @override _AddLaborPageState createState() => _AddLaborPageState();
}

class _AddLaborPageState extends State<AddLaborPage> {

  late final AddLaborPageController c;

  @override
  void initState() { 
    c = AddLaborPageController(widget.isEdit ? widget.item : null);
    super.initState();
    fetchRentToolCategories();
  }

  fetchRentToolCategories() async {
    c.categories = laborsCategoriesWithAllAsEntry;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "EDIT LABOR ENTRY" : "ADD LABOR POST", style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.transparent,
        actions: [
          if(widget.isEdit) TextButton(
            child: Text("Delete Post"),
            onPressed: () async {
              bool shouldDelete = await Dialogs.showConfirmationDialog(
                context: context, 
                title: "Delete Post?", 
                subtitle: "Are you sure you want to delete this post?"
              );
              if(!shouldDelete) return;
              c.deletePost(LaborsDoc.dummyInstance.firebaseColRef, c.docId!).then((void val) {
                Navigator.of(context).pop(true);
              }).onError((error, stackTrace) {
                print("onError() => error = "+error.toString());
              });
            },
          ),
        ],
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
                      Text("Labor Type", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: DropdownButtonFormField<int>(
                          isExpanded: true,
                          validator: (str) {
                            if(str==null) return "SELECT A LABOR TYPE";
                            else return null;
                          },
                          hint: Text("Select the type of labor you want to do"),
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
                      Text("WAGES", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          validator: (str) {
                            if(str!.trim().isEmpty) return "Wages cannot be empty";
                            else return null;
                          },
                          controller: c.amountC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "How much do you expect to be paid (approximately)"
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("WAGES PAY DURATION", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: DropdownButtonFormField<int>(
                          hint: Text("At what intervals you wish to be paid"),
                          items: ToolDurationTypes.data.entries.toList().map((e) {
                            return DropdownMenuItem<int>(
                              child: Text(e.value),
                              value: e.key,
                            );
                          }).toList(),
                          value: c.durationTypeId,
                          onChanged: (val) => setState(() => c.durationTypeId = val??c.durationTypeId),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text("DESCRIPTION", style: TextStyle(color: Colors.black),), 
                      SizedBox(height: 8,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: c.descC,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "The people about what type of work you can do, what kind of person you are, etc.",
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Text("POST IT", style: TextStyle(color: Colors.white,),),
                        ),
                        onPressed: () => c.uploadData(context, images: null),
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

  @override
  void dispose() async {
    DefaultCacheManager().emptyCache().then((value) {
      print("Cache Cleared");
    });
    super.dispose();
  }

}