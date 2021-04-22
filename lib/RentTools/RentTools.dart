import 'package:farmtool/Global/classes/ToolsDoc.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RentTools extends StatefulWidget {
  @override
  _RentToolsState createState() => _RentToolsState();
}

class _RentToolsState extends State<RentTools> {

  List<ToolsDoc> docs = [];

  @override
  void initState() { 
    super.initState();
    FirebaseFirestore.instance.collection("RentTools").get().then((snap) {
      setState(() {
        snap.docs.forEach((element) {
          docs.add(ToolsDoc.fromDocument(element));
        });
      });
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
                  return Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorBgColor.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(docs[index].title, style: TextStyle(
                                  fontSize: 18, color: Colors.white,
                                ),),
                              ),
                              Text("Rs. "+docs[index].rentAmount.toString(), style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
                              ),),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Text(docs[index].desc, style: TextStyle(
                            fontSize: 12, color: Colors.white,
                          ),),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}