import 'package:farmtool/AddToolPost/RentToolPage.dart';
import 'package:farmtool/AddToolPost/SellToolPage.dart';
import 'package:farmtool/AddVehiclePost/RentVehiclePage.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:farmtool/MyDrawer/DrawerMenu.dart';
import 'package:farmtool/MyDrawer/DrawerMenuItem.dart';
import 'package:farmtool/MyDrawer/DrawerSubMenuItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  int selectedMenuIndex = -1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (data) {},
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 48),
              width: double.maxFinite,
              height: double.maxFinite,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16,),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                          elevation: 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset("assets/images/farmer_image.png", height: 128, width: 128,),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Text(globalUser!.displayName!.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
                        TextButton(
                          style: ButtonStyle(visualDensity: VisualDensity.compact,),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Edit Profile Name", style: TextStyle(fontSize: 16, color: Colors.black54,),),
                              SizedBox(width: 8,),
                              Icon(Icons.edit, size: 20, color: Colors.black54,),
                            ],
                          ),
                          onPressed: () => showUpdateProfileNameBottomSheet(),
                        ),
                        SizedBox(height: 8,),
                        DrawerMenu(
                          selectedIndex: selectedMenuIndex, 
                          items: [
                            DrawerMenuItem(
                              title: "Add New Rent Post",
                              subTitle: "Put Tools, Vehicles or Warehouses On Rent",
                              icon: Icons.add_circle_outlined,
                              subMenuItems: [
                                DrawerSubMenuItem(
                                  title: "Add a tool on rent",
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentToolPage(),),),
                                ),
                                DrawerSubMenuItem(
                                  title: "Add a vehicle on rent",
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentVehiclePage(),),),
                                ),
                                DrawerSubMenuItem(
                                  title: "Add a warehouse on rent",
                                  onTap: () {},
                                ),
                              ],
                            ),
                            DrawerMenuItem(
                              title: "Add New Sell Post",
                              subTitle: "Sell Your 2nd Tools And Vehicles And Earn Money",
                              icon: Icons.monetization_on,
                              subMenuItems: [
                                DrawerSubMenuItem(
                                  title: "Add a tool for selling",
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellToolPage(),),),
                                ),
                                DrawerSubMenuItem(
                                  title: "Add a vehicle for selling",
                                  onTap: () {},
                                ),
                              ],
                            ),
                            DrawerMenuItem(
                              title: "Add New Labour Post",
                              subTitle: "Put Yourself Up For Labour And Earn Money",
                              icon: Icons.accessibility_new_rounded,
                              onTap: () {},
                            ),
                          ], 
                          onChange: (index) => setState(() => selectedMenuIndex = index),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.power_settings_new_rounded), 
                          label: Text("Logout"),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
                            });
                          }, 
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showUpdateProfileNameBottomSheet() {
    TextEditingController nameC = TextEditingController(text: globalUser!.displayName??"");
    showModalBottomSheet(context: context, builder: (_) => Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("UPDATE PROFILE NAME"),
          SizedBox(height: 8,),
          TextFomFieldContainer(
            child: TextFormField(
              controller: nameC,
              decoration: InputDecoration(hintText: "Write your name"),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            width: double.maxFinite,
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Update"),
              ),
              onPressed: () async {
                if(nameC.text.trim().isNotEmpty && globalUser!.displayName!.trim().toLowerCase()!=nameC.text.trim().toLowerCase()) {
                  await globalUser!.updateProfile(displayName: nameC.text.trim(),);
                  Navigator.of(context).pop();
                  if(mounted) setState(() {});
                }
              }, 
            ),
          )
        ],
      ),
    ),);
  }

}