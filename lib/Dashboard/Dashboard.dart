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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 16,),
          child: IconButton(
            color: Colors.black,
            icon: Icon(Icons.menu,),
            onPressed: () {},
          ),
        ),
        titleSpacing: 16,
        title: Text("My Dashboard", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400,),),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.power_settings_new_rounded,),
            onPressed: () async {
              await Amplify.Auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16,),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("Hi"+(gUserAttributes == null ? "" : ", "+gUserAttributes.firstWhere((e) => e.userAttributeKey=="name").value), style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w400,
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Have a nice day", style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w700,
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Monday, 19 April", style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54,
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Expanded(
                  child: GridView(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9, mainAxisSpacing: 4, crossAxisSpacing: 4,),
                    children: [
                      cardTile("Buy Tools", "On Rent", Icons.toc_outlined),
                      cardTile("Buy Vehicles", "On Rent", Icons.drive_eta),
                      cardTile("Buy Warehouses", "On Rent", Icons.house_rounded),
                      cardTile("Sell Tools", "2nd Hand", Icons.attach_money),
                      cardTile("Sell Vehicles", "2nd Hand", Icons.drive_eta),
                      cardTile("Get Labour", "On Fair Rates", Icons.drive_eta),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardTile(String title, String subTitle, IconData icon) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
      child: Container(
        decoration: BoxDecoration(
          color: colorBgColor.withOpacity(0.75),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, height: 1.5),),
            Text(subTitle, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70),),
            Icon(icon, size: 64, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}