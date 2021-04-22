import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/classes/ToolsDoc.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';

class AddTool extends StatefulWidget {
  @override
  _AddToolState createState() => _AddToolState();
}

class _AddToolState extends State<AddTool> {

  TextEditingController nameC = TextEditingController();
  TextEditingController catC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();

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
    ToolsDoc tool = ToolsDoc.newDoc(
      title: nameC.text.trim(), 
      category: catC.text.trim(), 
      desc: descC.text.trim(), 
      rentAmount: double.parse(amountC.text.trim()), 
      rentDurationType: 0,
      renterUID: globalUser!.uid, 
      createdTimestamp: Timestamp.now(), 
      id: ""
    );

    var docRef = await FirebaseFirestore.instance.collection("RentTools").add(tool.toMap());
    print(docRef.id);
  }
}