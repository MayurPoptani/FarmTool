import 'dart:async';

import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/functions/locationFunctions.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/HorizontalSelector.dart';
import 'package:farmtool/RentVehiclesList/RentVehicleListItem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class RentVehicles extends StatefulWidget {
  @override
  _RentVehiclesState createState() => _RentVehiclesState();
}

class _RentVehiclesState extends State<RentVehicles> {

  List<RentVehiclesDoc> docs = [];
  late Stream<List<DocumentSnapshot>> stream;
  StreamSubscription? streamSubscription;
  int selectedCategoryId = 0;
  int radius = 200;

  @override
  void initState() { 
    super.initState();
    getData();
  }

  getData() async {
    if(globalPos!=null) globalPos = await getLocation();
    var point = GeoFirePoint(globalPos!.latitude, globalPos!.longitude);
    stream = Geoflutterfire()
      .collection(
        collectionRef: FirebaseFirestore.instance.collection("RentVehicles")
        .where(RentVehiclesDoc.ISACTIVE, isEqualTo: true)
        .where(RentVehiclesDoc.CATEGORY, whereIn: selectedCategoryId==0 ? toolsCategories.entries.map((e) => e.key).toList() : [selectedCategoryId])
      ).within(center: point, radius: radius.toDouble(), field: RentVehiclesDoc.LOCATION, strictMode: true);
    streamSubscription = stream.listen((event) {
      docs.clear();
      print("NEW DATA IN STREAM");
      print("DATA LENGTH = "+event.length.toString());
      event.forEach((element) => docs.add(RentVehiclesDoc.fromDocument(element)));
      if(mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded,), 
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Rent Vehicles", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),),
        titleSpacing: 0,
        actions: [
          PopupMenuButton<int>(
            icon: Text(radius.toString()+" KM", style: TextStyle(color: Colors.black),),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text("10 KM"), value: 10,),
              PopupMenuItem(child: Text("50 KM"), value: 50,),
              PopupMenuItem(child: Text("100 KM"), value: 100,),
              PopupMenuItem(child: Text("200 KM"), value: 200,),
            ],
            initialValue: radius,
            onSelected: (val) {
              radius = val;
              getData();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   padding: EdgeInsets.only(bottom: 16, left: 12, right: 12,),
            //   child: Text("Rent Tools", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),),  
            // ),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
            ),
            HorizontalSelector<int>(
              items: (vehiclesCategoriesWithAllAsEntry.entries.toList()..sort((a, b) => a.key - b.key)),
              initialSelection: selectedCategoryId,
              onChange: (val) {
                if(selectedCategoryId!=val) setState(() {
                  selectedCategoryId = val;
                  getData();
                });
              },
            ),
            SizedBox(height: 24,),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text("Available Vehicles", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (_, index) {
                  return RentVehicleListItem(docs[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if(streamSubscription!=null) streamSubscription!.cancel();
    super.dispose();
  }
}