import 'package:farmtool/MyDrawer/MyDrawer.dart';
import 'package:farmtool/AddToolPost/RentToolPage.dart';
import 'package:farmtool/Global/functions/locationFunctions.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:farmtool/RentToolsList/RentTools.dart';
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
    getLocation().then((value) {
      print("Lat = "+value.latitude.toString());
      print("Long = "+value.longitude.toString());
      globalPos = value;
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
        title: Text("My Dashboard", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400,),),
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
                    Text("Hi${globalUser?.displayName!=null?(", "+globalUser!.displayName!):" User"}", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400,),),
                    Text("Have a nice day", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),),
                    SizedBox(height: 4,),
                    Text("Wednesday, 21 April", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54,),),
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
                      title: "Buy Tools", 
                      subTitle: "On Rent", 
                      asset: "assets/images/rent_tools.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentTools()));
                      }
                    ),
                    cardTile(
                      title: "Buy Vehicles", 
                      subTitle:"On Rent", 
                      asset: "assets/images/rent_vehicles.png"),
                    cardTile(
                      title: "Buy Warehouses", 
                      subTitle:"On Rent", 
                      asset: "assets/images/rent_warehouses.png"),
                    cardTile(
                      title: "Buy Tools", 
                      subTitle:"2nd Hand", 
                      asset: "assets/images/sell_tools.png"),
                    cardTile(
                      title: "Buy Vehicles", 
                      subTitle:"2nd Hand", 
                      asset: "assets/images/sell_vehicles.png"),
                    cardTile(
                      title: "Get Labour", 
                      subTitle:"On Fair Rates",
                      asset: "assets/images/get_labour.png"),
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