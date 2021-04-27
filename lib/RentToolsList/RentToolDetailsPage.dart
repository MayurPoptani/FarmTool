import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';

class RentToolDetailsPage extends StatefulWidget {
  final RentToolsDoc item;
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
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 13,
                  child: Container(
                    // height: MediaQuery.of(context).size.width*.75,
                    width: double.maxFinite,
                    child: Stack(
                      // fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 8),]
                          ),
                          child: ClipRRect(
                            child: Image.network(widget.item.imageUrls.first,
                              fit: BoxFit.fill,
                              width: double.maxFinite,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8, right: 8,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                            elevation: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(Distance().as(
                                      LengthUnit.Kilometer, 
                                      LatLng(globalPos!.latitude, globalPos!.longitude),
                                      LatLng(widget.item.geoHashPoint.geoPoint.latitude, widget.item.geoHashPoint.geoPoint.longitude),
                                    ).toStringAsFixed(0),
                                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400,),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("Km Away", 
                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400,),
                                    textAlign: TextAlign.center
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Expanded(
                  flex: 17,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.item.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                              SizedBox(height: 8,),
                              Text("Rs. "+widget.item.rentAmount.toString()+" "+VehicleDurationTypes.data[widget.item.rentDurationType]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                              SizedBox(height: 8,),
                              Text((widget.item.desc+" "), style: TextStyle(fontSize: 16, color: Colors.black45, fontWeight: FontWeight.w200),),
                              SizedBox(height: 8,),
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