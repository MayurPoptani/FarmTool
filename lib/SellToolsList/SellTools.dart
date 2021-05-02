import 'dart:async';

import 'package:farmtool/Global/classes/SellToolsDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/GridListTile.dart';
import 'package:farmtool/Global/widgets/HorizontalSelector.dart';
import 'package:farmtool/SellToolsList/SellToolDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class SellTools extends StatefulWidget {
  @override
  _SellToolsState createState() => _SellToolsState();
}

class _SellToolsState extends State<SellTools> {

  List<SellToolsDoc> docs = [];
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
    // if(globalPos!=null) globalPos = await getLocation();
    var point = GeoFirePoint(globalPos!.latitude, globalPos!.longitude);
    stream = Geoflutterfire()
      .collection(
        collectionRef: FirebaseFirestore.instance.collection("Posts/SellTools/Entries")
        .where(SellToolsDoc.ISACTIVE, isEqualTo: true)
        .where(SellToolsDoc.CATEGORY, whereIn: selectedCategoryId==0 ? toolsCategories.entries.map((e) => e.key).toList() : [selectedCategoryId])
      ).within(center: point, radius: radius.toDouble(), field: SellToolsDoc.LOCATION, strictMode: true);
    streamSubscription = stream.listen((event) {
      docs.clear();
      print("NEW DATA IN STREAM");
      print("DATA LENGTH = "+event.length.toString());
      event.forEach((element) => docs.add(SellToolsDoc.fromDocument(element)));
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
        title: Text(SELLTOOLLISTPAGE.APPBAR_LABEL, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),),
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
              child: Text(SELLTOOLLISTPAGE.CAREGORIES_LABEL, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
            ),
            HorizontalSelector<int>(
              items: (toolCategoriesWithAllAsEntry.entries.toList()..sort((a, b) => a.key - b.key)),
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
              child: Text(SELLTOOLLISTPAGE.LIST_LABEL, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: GridListTile.GRIDCROSSRATIO,
                ),
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (_, index) {
                  return GridListTile(
                    header: "Rs. "+docs[index].sellAmount.toStringAsFixed(0),
                    title: docs[index].title,
                    subtitle: toolsCategories[docs[index].category]!,
                    imageUrl: docs[index].imageUrls[0]??null,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellToolDetailsPage(docs[index])));
                    },
                  );
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