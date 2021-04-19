import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    getUserData();
  }


  getUserData() async {
    gUserAttributes = await Amplify.Auth.fetchUserAttributes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Expanded(
                flex: 14,
                child: Container(
                  decoration: BoxDecoration(
                    color: greenScaffoldColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16),),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("Hello, "+(gUserAttributes == null ? "User" : gUserAttributes.firstWhere((e) => e.userAttributeKey=="name").value), 
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white,),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.power_settings_new_rounded, color: Colors.white,),
                              ),
                              onTap: () async {
                                await Amplify.Auth.signOut();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Expanded(
                        child: GridView(
                          reverse: true,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, 
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none,),
                              elevation: 8,
                              color: Colors.white,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Rent", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                                    Text("Tools", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none,),
                              elevation: 8,
                              color: Colors.white,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Rent", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                                    Text("Vehicles", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400,), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ],   
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GridView(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8,),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none,),
                            elevation: 8,
                            color: greenScaffoldColor,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Rent", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.white,), textAlign: TextAlign.center,),
                                  Text("Warehouse", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white,), textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none,),
                            elevation: 8,
                            color: greenScaffoldColor,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Sell", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.white,), textAlign: TextAlign.center,),
                                  Text("2nd Hands", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white,), textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        ],   
                      ),
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
}