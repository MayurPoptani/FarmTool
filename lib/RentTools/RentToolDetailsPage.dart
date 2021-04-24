import 'package:farmtool/Global/classes/ToolsDoc.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:flutter/material.dart';

class RentToolDetailsPage extends StatefulWidget {
  final ToolsDoc item;
  const RentToolDetailsPage(this.item, {Key? key}) : super(key: key);
  @override
  _RentToolDetailsPageState createState() => _RentToolDetailsPageState();
}

class _RentToolDetailsPageState extends State<RentToolDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.item.id,
      child: Scaffold(
        // backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            // padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 8)
                            ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(widget.item.imageUrls.first,
                              height: MediaQuery.of(context).size.width - 32,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.item.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                              SizedBox(height: 16,),
                              Text("Rs. "+widget.item.rentAmount.toString()+" "+DurationTypes.data[widget.item.rentDurationType]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                              SizedBox(height: 16,),
                              Text((widget.item.desc+" ")*30, style: TextStyle(fontSize: 16, color: Colors.black45, fontWeight: FontWeight.w200),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text("Mark Favourite"),
                          ),
                          onPressed: () {

                          }, 
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text("Call"),
                          ),
                          onPressed: () {

                          }, 
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}