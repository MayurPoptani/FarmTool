import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RentTools extends StatefulWidget {
  @override
  _RentToolsState createState() => _RentToolsState();
}

class _RentToolsState extends State<RentTools> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Rent Tools", style: TextStyle(color: Colors.black,),),
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded,), 
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<QuerySnapshot>(
          initialData: null,
          future: FirebaseFirestore.instance.collection("RentTools").get(),
          builder: ((con, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting) 
              return CircularProgressIndicator();
            else if(snapshot.connectionState==ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (con, index) {
                  return Text(snapshot.data!.docs[index].id);
                }
              );
            } else return Container();
          }),
        ),
      ),
    );
  }
}