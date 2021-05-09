import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/LaborsList/Labors.dart';
import 'package:farmtool/MyDrawer/MyDrawer.dart';
import 'package:farmtool/Global/functions/locationFunctions.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/RentToolsList/RentTools.dart';
import 'package:farmtool/RentVehiclesList/RentVehicles.dart';
import 'package:farmtool/RentWarehousesList/RentWarehouses.dart';
import 'package:farmtool/SellToolsList/SellTools.dart';
import 'package:farmtool/SellVehiclesList/SellVehicles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((user) {
      globalUser = user;
      if(mounted) setState(() {});
    });
    globalPos = getSavedLocation();
    print("globalPos = getSavedLocation() => "+(globalPos!=null).toString());
    getLocation().then((value) {
      print("Lat = "+value.latitude.toString());
      print("Long = "+value.longitude.toString());
      globalPos = value;
      print("calling saveLocation()");
      saveLocation(globalPos!);
      getLocationStream()
      .listen((event) {
        // print("Distance = "+getDistanceBetween(GeoPoint(event.latitude, event.longitude), GeoPoint(getSavedLocation()!.latitude, getSavedLocation()!.longitude)).toString());
        if(getSavedLocation()==null) {
          saveLocation(event);
        } else if(getDistanceBetween(GeoPoint(event.latitude, event.longitude), GeoPoint(getSavedLocation()!.latitude, getSavedLocation()!.longitude)) > 0.25) {
          saveLocation(event);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: myDrawer(),
      // drawer: myDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 24,
        title: Text(DASHBOARD.MY_DASHBOARD, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400,),),
        actions: [
          Builder(
            builder: (_) => Container(
              margin: EdgeInsets.symmetric(horizontal: 8,),
              padding: EdgeInsets.all(4),
              child: InkWell(
                onTap: () => Scaffold.of(_).openEndDrawer(),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset("assets/images/farmer_image.png", fit: BoxFit.fitHeight,),
                  ),
                ),
              ),
            ),
          ),
          // IconButton(
          //   color: Colors.black,
          //   icon: Icon(Icons.power_settings_new_rounded,),
          //   onPressed: () async {
          //     await FirebaseAuth.instance.signOut().then((value) {
          //       globalUser = null;
          //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
          //     }).onError((error, stackTrace) {
          //       print("signOut.onError.error = "+error.toString());
          //     });
          //   },
          // ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DASHBOARD.HI+"${globalUser?.displayName!=null?(globalUser!.displayName!):" User"}", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400,),),
                    Text(DASHBOARD.GREETINGS, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),),
                    // SizedBox(height: 4,),
                    // Text("Wednesday, 21 April", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54,),),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Expanded(
                child: GridView(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9, mainAxisSpacing: 4, crossAxisSpacing: 4,),
                  children: [
                    cardTile(
                      title: DASHBOARD.BUY_TOOLS, 
                      subTitle: DASHBOARD.ON_RENT, 
                      asset: "assets/images/rent_tools.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentTools()));
                      }
                    ),
                    cardTile(
                      title: DASHBOARD.BUY_VEHICLES, 
                      subTitle: DASHBOARD.ON_RENT, 
                      asset: "assets/images/rent_vehicles.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentVehicles()));
                      }
                    ),
                    cardTile(
                      title: DASHBOARD.BUY_WAREHOUSES, 
                      subTitle: DASHBOARD.ON_RENT, 
                      asset: "assets/images/rent_warehouses.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentWarehouses()));
                      }
                    ),
                    cardTile(
                      title: DASHBOARD.BUY_TOOLS, 
                      subTitle: DASHBOARD.SECOND_HAND, 
                      asset: "assets/images/sell_tools.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellTools()));
                      }
                    ),
                    cardTile(
                      title: DASHBOARD.BUY_VEHICLES, 
                      subTitle: DASHBOARD.SECOND_HAND, 
                      asset: "assets/images/sell_vehicles.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellVehicles()));
                      }  
                    ),
                    cardTile(
                      title: DASHBOARD.GET_LABOR, 
                      subTitle: DASHBOARD.ON_FAIR_RATES,
                      asset: "assets/images/get_labour.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Labors()));
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myDrawer() {
    return MyDrawer();
    // return Drawer(
    //   child: SafeArea(
    //     child: Column(
    //       children: [
    //         TextButton(
    //           child: Container(
    //             padding: EdgeInsets.all(16),
    //             child: Text("Add Item on Rent", style: TextStyle(color: Colors.black,),),
    //           ),
    //           onPressed: () {
    //             Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddTool()));
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget cardTile({required String title, required String subTitle, required String asset, Function? onTap}) {
    return InkWell(
      onTap: () {
        if(onTap!=null) onTap();
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Image.asset(asset, height: 54, color: Colors.black,),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: 16,),
              Text(title, 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black, height: 1.5),
                textAlign: TextAlign.center,
              ),
              Text(subTitle, 
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}