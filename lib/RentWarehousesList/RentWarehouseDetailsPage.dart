import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmtool/Global/widgets/MyExtentions.dart';

class RentWarehouseDetailsPage extends StatefulWidget {
  final RentWarehousesDoc item;
  const RentWarehouseDetailsPage(this.item, {Key? key}) : super(key: key);
  @override
  _RentWarehouseDetailsPage createState() => _RentWarehouseDetailsPage();
}

class _RentWarehouseDetailsPage extends State<RentWarehouseDetailsPage> {
  bool favourite = false;
  int imgIndex = 0;

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
                  flex: 27,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.maxFinite,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Card(
                          elevation: 16,
                          shadowColor: Colors.black54,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: PageView.builder(
                                        itemCount: widget.item.imageUrls.length,
                                        onPageChanged: (i) => setState(() => imgIndex = i),
                                        itemBuilder: (_, i) {
                                          return Image.network(
                                            widget.item.imageUrls[i], 
                                            width: double.maxFinite,
                                            fit: BoxFit.contain,
                                          );
                                        },
                                      )
                                    ),
                                    if(widget.item.imageUrls.length>0) Positioned(
                                      bottom: 8,
                                      child: Card(
                                        elevation: 8,
                                        shadowColor: Colors.black54,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4,),
                                          child: Row(
                                            children: List.generate(widget.item.imageUrls.length, (index) => Container(
                                              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                              height: 8, width: 8,
                                              decoration: BoxDecoration(
                                                color: imgIndex == index ? Colors.green.shade900 : Colors.black45,
                                                shape: BoxShape.circle,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: 56,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.centerLeft,
                                child: Text(widget.item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                              ),
                            ],
                          )
                        ),
                        Positioned(
                          top: 16, right: 16,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white60,
                                    spreadRadius: 6,
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(favourite ? Icons.favorite_border_rounded : Icons.favorite_rounded, 
                                  color: Colors.red,  
                                ),
                              ),
                            ),
                            onTap: () => setState(() => favourite=!favourite),
                          ),
                        ),
                        Positioned(
                          top: 16, left: 16,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white60,
                                    spreadRadius: 6,
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.arrow_back_rounded, color: Colors.red,),
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 13,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 32,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              displayItem(
                                icon: Icons.av_timer_sharp,
                                label: "RENT PRICE",
                                text: "Rs. "+widget.item.rentAmount.toStringAsFixed(0)
                                  + (widget.item.rentingType==2 ? " Per Square foot" : ""),
                              ),
                              16.heightbox,
                              displayItem(
                                icon: Icons.av_timer_sharp,
                                label: "FOR DURATION",
                                text: WarehouseDurationTypes.data[widget.item.rentDurationType]!,
                              ),
                              16.heightbox,
                              displayItem(
                                icon: Icons.category_rounded,
                                label: "CATEGORY",
                                text: warehousesCategories[widget.item.category]!,
                              ),
                              16.heightbox,
                              displayItem(
                                icon: Icons.category_rounded,
                                label: "AREA (PER SQUARE FOOT)",
                                text: widget.item.area.toStringAsFixed(0),
                              ),
                              16.heightbox,
                              displayItem(
                                icon: Icons.category_rounded,
                                label: "LOCATION TYPE",
                                text: warehousesLocationTypes[widget.item.locationType]!,
                              ),
                              16.heightbox,
                              displayItem(
                                icon: Icons.indeterminate_check_box,
                                label: RENTTOOLDETAILSPAGE.RENTER_NAME_LABEL,
                                text: widget.item.uidName,
                              ),
                              16.heightbox,
                              displayItem(
                                icon: Icons.indeterminate_check_box,
                                label: RENTTOOLDETAILSPAGE.DESCRIPTION_LABEL,
                                text: widget.item.desc,
                              ),
                              SizedBox(height: 16,),
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
                            child: Text(RENTTOOLDETAILSPAGE.BUTTON_LABEL, style: TextStyle(fontSize: 18),),
                          ),
                          onPressed: () async {
                            if(await UrlLauncher.canLaunch("tel:"+widget.item.uidPhone)) {
                              UrlLauncher.launch("tel:"+widget.item.uidPhone);
                            }
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

  Widget displayItem({required IconData icon, required String label, required String text, double textSize = 16}) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Icon(icon, color: Colors.white,),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green,
            ),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.black54, fontSize: 14),),
                Text(text, style: TextStyle(color: Colors.black, fontSize: textSize),),
              ],
            ),
          )
        ],
      ),
    );
  }
}