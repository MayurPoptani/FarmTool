import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/RentToolsList/RentToolDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class RentToolListItem extends StatelessWidget {

  final RentToolsDoc item;
  RentToolListItem(this.item);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black26,
        // ),
        borderRadius: BorderRadius.circular(16)
      ),
      margin: EdgeInsets.only(bottom: 8),
      // padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.indigo.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentToolDetailsPage(item)));
            },
            child: Hero(
              tag: item.id,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // padding: EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                // borderRadius: BorderRadius.only(
                                //   bottomLeft: Radius.circular(16),
                                //   topLeft: Radius.circular(16),
                                // ),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  child: Image.network(item.imageUrls.first,
                                    width: MediaQuery.of(context).size.width*.25,
                                    height: MediaQuery.of(context).size.width*.18,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16,),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  height: MediaQuery.of(context).size.width*.18,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title, 
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,),
                                      ),
                                      Text(item.categoryName, 
                                        style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400,),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("By Chacha Chaudhari",
                                              // item.renterName, 
                                              style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Distance().as(
                            LengthUnit.Kilometer, 
                            LatLng(globalPos!.latitude, globalPos!.longitude),
                            LatLng(item.geoHashPoint.geoPoint.latitude, item.geoHashPoint.geoPoint.longitude),
                          ).toString()+" Kms away",
                           style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400,),
                        ),
                        SizedBox(height: 8,),
                        Text("Rs. "+item.rentAmount.toString()+" "+VehicleDurationTypes.data[item.rentDurationType]!, 
                          style: TextStyle(color: Colors.green.shade700, fontSize: 18, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}