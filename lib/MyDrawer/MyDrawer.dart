import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/AddToolPost/RentToolPage/RentToolPage.dart';
import 'package:farmtool/AddToolPost/SellToolPage/SellToolPage.dart';
import 'package:farmtool/AddVehiclePost/RentVehiclePage/RentVehiclePage.dart';
import 'package:farmtool/AddVehiclePost/SellVehiclePage/SellVehiclePage.dart';
import 'package:farmtool/ChangeLanguagePage/ChangeLanguagePage.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/LoginPage/LoginPage.dart';
import 'package:farmtool/MyDrawer/DrawerMenu.dart';
import 'package:farmtool/MyDrawer/DrawerMenuItem.dart';
import 'package:farmtool/MyDrawer/DrawerSubMenuItem.dart';
import 'package:farmtool/MyPosts/MyPosts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
                  child: Column(
                    children: [
                      Expanded(
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
                              if(globalUser!=null) Text(globalUser!.displayName!.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
                              TextButton(
                                style: ButtonStyle(visualDensity: VisualDensity.compact,),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(MYDRAWER.EDIT_PROFILE_NAME.tr(), style: TextStyle(fontSize: 16, color: Colors.black54,),),
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
                                    title: MYDRAWER.ADD_NEW_RENT_POST_TITLE.tr(),
                                    subTitle: MYDRAWER.ADD_NEW_RENT_POST_SUBTITLE.tr(),
                                    icon: Icons.add_circle_outlined,
                                    subMenuItems: [
                                      DrawerSubMenuItem(
                                        title: MYDRAWER.ADD_NEW_RENT_TOOL_TITLE.tr(),
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentToolPage(),),),
                                      ),
                                      DrawerSubMenuItem(
                                        title: MYDRAWER.ADD_NEW_RENT_VEHICLE_TITLE.tr(),
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentVehiclePage(),),),
                                      ),
                                      DrawerSubMenuItem(
                                        title: MYDRAWER.ADD_NEW_RENT_WAREHOUSE_TITLE.tr(),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                  DrawerMenuItem(
                                    title: MYDRAWER.ADD_NEW_SELL_POST_TITLE.tr(),
                                    subTitle: MYDRAWER.ADD_NEW_SELL_POST_SUBTITLE.tr(),
                                    icon: Icons.monetization_on,
                                    subMenuItems: [
                                      DrawerSubMenuItem(
                                        title:MYDRAWER.ADD_NEW_SELL_TOOL_TITLE.tr(),
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellToolPage(),),),
                                      ),
                                      DrawerSubMenuItem(
                                        title: MYDRAWER.ADD_NEW_SELL_VEHICLE_TITLE.tr(),
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SellVehiclePage(),),),
                                      ),
                                    ],
                                  ),
                                  DrawerMenuItem(
                                    title: MYDRAWER.ADD_NEW_LABOR_POST_TITLE.tr(),
                                    subTitle: MYDRAWER.ADD_NEW_LABOR_POST_SUBTITLE.tr(),
                                    icon: Icons.accessibility_new_rounded,
                                    onTap: () {},
                                  ),
                                  
                                  DrawerMenuItem(
                                    title: MYDRAWER.MY_POSTS_TITLE.tr(),
                                    subTitle: MYDRAWER.MY_POSTS_SUBTITLE.tr(),
                                    icon: Icons.menu_open_rounded,
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyPosts(),),),
                                  ),

                                  DrawerMenuItem(
                                    title: MYDRAWER.CHANGE_LANGUAGE_TITLE.tr(),
                                    subTitle: MYDRAWER.CHANGE_LANGUAGE_SUBTITLE.tr(),
                                    icon: Image.asset("assets/images/language.png", color: Colors.black, height: 24,),
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChangeLanguagePage(),),),
                                  ),
                                ], 
                                onChange: (index) => setState(() => selectedMenuIndex = index),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        child: TextButton.icon(
                          icon: Icon(Icons.power_settings_new_rounded, color: Colors.red), 
                          label: Text(MYDRAWER.LOGOUT.tr(), style: TextStyle(color: Colors.black),),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
                            });
                          }, 
                        ),
                      ),
                    ],
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
          Text(MYDRAWER.EDIT_PROFILE_NAME.tr()),
          SizedBox(height: 8,),
          TextFomFieldContainer(
            child: TextFormField(
              controller: nameC,
              decoration: InputDecoration(hintText: MYDRAWER.WRITE_YOUR_NAME.tr()),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            width: double.maxFinite,
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(MYDRAWER.UPDATE.tr()),
              ),
              onPressed: () async {
                if(nameC.text.trim().isNotEmpty && globalUser!.displayName!.trim().toLowerCase()!=nameC.text.trim().toLowerCase())
                  updateDatabaseAndProfile(nameC.text.trim());
              }, 
            ),
          ),
        ],
      ),
    ),);
  }

  updateDatabaseAndProfile(String name) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      // QuerySnapshot qsnap =  await FirebaseFirestore.instance.collectionGroup("Posts").where("uid", isEqualTo: globalUser!.uid).get();
      QuerySnapshot qsnap =  await FirebaseFirestore.instance.collectionGroup("Entries").where("uid", isEqualTo: globalUser!.uid).get();
      print(qsnap.docs.length);
      for(int i = 0 ; i< qsnap.docs.length ; i ++) {
        transaction.update(qsnap.docs[i].reference, {
          "uid_name" : name
        });
      }
      return transaction;
    }).then((value) async {
      await globalUser!.updateProfile(displayName: name.trim(),);
      Navigator.of(context).pop();
      if(mounted) setState(() {});
    }).onError((error, stackTrace) {
      print("TransactionError Error = "+error.toString());
      print("TransactionError StackTrace  = "+stackTrace.toString());
    });
    // await globalUser!.updateProfile(displayName: name.trim(),);
    // Navigator.of(context).pop();
    // if(mounted) setState(() {}); 
  }

}