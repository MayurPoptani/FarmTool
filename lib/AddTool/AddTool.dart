import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/GeoHashPoint.dart';
import 'package:farmtool/Global/classes/ToolsDoc.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:images_picker/images_picker.dart';

class AddTool extends StatefulWidget {
  @override
  _AddToolState createState() => _AddToolState();
}

class _AddToolState extends State<AddTool> {

  TextEditingController nameC = TextEditingController();
  TextEditingController catC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  List<Media>? images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tool", style: TextStyle(color: Colors.black),), 
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black,), 
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFomFieldContainer(
                      child: TextFormField(
                        controller: nameC,
                        decoration: InputDecoration(
                          labelText: "Name of the tool"
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextFomFieldContainer(
                      child: TextFormField(
                        controller: catC,
                        decoration: InputDecoration(
                          labelText: "Category"
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextFomFieldContainer(
                      child: TextFormField(
                        controller: amountC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Rent Amount"
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextFomFieldContainer(
                      child: TextFormField(
                        controller: descC,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextFomFieldContainer(
                      child: TextFormField(
                        controller: addressC,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Address",
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextButton(
                      child: Text("Select Image"),
                      onPressed: () async {
                        images = await ImagesPicker.pick(
                          count: 5,
                          pickType: PickType.image,
                        );
                        if(images!=null) {
                          images!.forEach((element) {
                            print(element.path);
                          });
                        }
                        setState(() {});
                      },
                    ),
                    if(images!=null && images!.length!=0) Row(
                      children: images!.map((e) {
                        return Image.file(File(e.path!), height: 64, width: 64,);
                      }).toList(),
                    ),
                    SizedBox(height: 8,),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Text("Save", style: TextStyle(color: Colors.white,),),
              ),
              onPressed: () {
                uploadData();
              },
            ),
          ],
        ),
      ),
    );
  }

  uploadData() async {
    print("uploadData()");
    GeoFirePoint point = Geoflutterfire().point(latitude: globalPos!.latitude, longitude: globalPos!.longitude);
    ToolsDoc tool = ToolsDoc.newDoc(
      title: nameC.text.trim(), 
      category: catC.text.trim(), 
      desc: descC.text.trim(), 
      rentAmount: double.parse(amountC.text.trim()), 
      rentDurationType: 0,
      renterUID: globalUser!.uid, 
      createdTimestamp: Timestamp.now(),
      geoHashPoint: GeoHashPoint(point.hash, point.geoPoint), 
      id: "",
    );

    var docRef = await FirebaseFirestore.instance.collection("RentTools").add(tool.toMap());
    print(docRef.id);
  }
}