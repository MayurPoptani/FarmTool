import 'dart:async';

import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/functions/locationFunctions.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/RentTools/RentToolListItem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class RentTools extends StatefulWidget {
  @override
  _RentToolsState createState() => _RentToolsState();
}

class _RentToolsState extends State<RentTools> {

  List<RentToolsDoc> docs = [];
  late Stream<List<DocumentSnapshot>> stream;
  StreamSubscription? streamSubscription;
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
        collectionRef: FirebaseFirestore.instance.collection("RentTools")
        .where(RentToolsDoc.ISACTIVE, isEqualTo: true)
      ).within(center: point, radius: radius.toDouble(), field: RentToolsDoc.LOCATION, strictMode: true);
    streamSubscription = stream.listen((event) {
      docs.clear();
      print("NEW DATA IN STREAM");
      print("DATA LENGTH = "+event.length.toString());
      event.forEach((element) => docs.add(RentToolsDoc.fromDocument(element)));
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
        actions: [
          PopupMenuButton<int>(
            // icon: Icon(Icons.more_vert_rounded, color: Colors.black,),
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
            Container(
              padding: EdgeInsets.only(bottom: 16, left: 12, right: 12,),
              child: Text("Rent Tools", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),),  
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (_, index) {
                  return RentToolListItem(docs[index]);
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