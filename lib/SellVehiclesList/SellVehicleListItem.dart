import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/RentToolsList/RentToolDetailsPage.dart';
import 'package:farmtool/RentVehiclesList/RentVehicleDetailsPage.dart';
import 'package:farmtool/SellVehiclesList/SellVehicleDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class SellVehicleListItem extends StatefulWidget {

  final SellVehiclesDoc item;
  SellVehicleListItem(this.item);

  @override
  _SellVehicleListItemState createState() => _SellVehicleListItemState();
}

class _SellVehicleListItemState extends State<SellVehicleListItem> {

  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      shadowColor: Colors.black54,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8,),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellVehicleDetailsPage(widget.item)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Card(
                      elevation: 16,
                      shadowColor: Colors.black54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          child: Image.network(widget.item.imageUrls.first,
                            // height: MediaQuery.of(context).size.width*.375,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        child: Text("Rs. "+widget.item.sellAmount.toStringAsFixed(0), style: TextStyle(fontSize: 12,),),
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 4, 
                              color: Colors.white60
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.item.model, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                          Text(widget.item.categoryName, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54,)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(favourite ? Icons.favorite_border_rounded : Icons.favorite_rounded, 
                        color: Colors.red,  
                      ),
                    ),
                    onTap: () => setState(() => favourite=!favourite),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}