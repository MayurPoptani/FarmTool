import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/AddLaborPost/AddLaborPost.dart';
import 'package:farmtool/AddToolPost/RentToolPage/RentToolPage.dart';
import 'package:farmtool/AddToolPost/SellToolPage/SellToolPage.dart';
import 'package:farmtool/AddVehiclePost/RentVehiclePage/RentVehiclePage.dart';
import 'package:farmtool/AddVehiclePost/SellVehiclePage/SellVehiclePage.dart';
import 'package:farmtool/AddWarehousePost/AddWarehousePage.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/LaborsDoc.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/classes/SellToolsDoc.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/functions/Dialogs.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/GridListTile.dart';
import 'package:farmtool/Global/widgets/MyPostGridListTile.dart';
import 'package:farmtool/MyPosts/pages/PostList.dart';
import 'package:farmtool/RentWarehousesList/RentWarehouses.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  GlobalKey<PostListState> rentToolsKey = GlobalKey();
  GlobalKey<PostListState> rentVehiclesKey = GlobalKey();
  GlobalKey<PostListState> sellToolsKey = GlobalKey();
  GlobalKey<PostListState> sellVehiclesKey = GlobalKey();
  GlobalKey<PostListState> rentWarehousesKey = GlobalKey();
  GlobalKey<PostListState> laborsKey = GlobalKey();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("My Posts", style: TextStyle(color: Colors.black),),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded,), 
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16).copyWith(top: 0),
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: [
                Tab(child: Text("Rented Tools"),),
                Tab(child: Text("Rented Vehicles"),),
                Tab(child: Text("Renting Warehouses"),),
                Tab(child: Text("Selling Tools"),),
                Tab(child: Text("Selling Vehicles"),),
                Tab(child: Text("Labors"),),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(32)
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  PostList(
                    key: rentToolsKey,
                    query: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("RentTools")
                      .collection("Entries")
                      .where(BaseDoc.UID, isEqualTo: globalUser!.uid), 
                    itemBuilder: (i, item) {
                      var obj = RentToolsDoc.fromDocument(item);
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: MyPostListTile(
                          title: obj.title*20,
                          subtitle: toolsCategories[obj.category]!, 
                          text: "Rs. "+obj.rentAmount.toInt().toString() + " " + ToolDurationTypes.data[obj.rentDurationType]!,
                          imageUrl: obj.imageUrls[0]??null,
                          onEditTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => RentToolPage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              rentToolsKey.currentState!.refreshList();
                            }
                          },
                          secondButtonLabel: obj.isAvailable ? "Make Unavailable" : "Make Available",
                          onSecondButtonTap: () async {
                            bool confirm = await Dialogs.showConfirmationDialog(
                              context: context, 
                              title: "Make ${obj.isAvailable?'unavailable':'available'}?", 
                              subtitle: "Are you sure you want to make this item ${obj.isAvailable?'unavailable':'available'}?",
                            );
                            print(confirm);
                            if(confirm) {
                              bool updated = await changeAvailiblilty(obj);
                              if(updated) rentToolsKey.currentState!.refreshList();
                            }
                          },
                        ),
                      );
                    }
                  ),
                  PostList(
                    key: rentVehiclesKey,
                    query: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("RentVehicles")
                      .collection("Entries")
                      .where(BaseDoc.UID, isEqualTo: globalUser!.uid),
                    itemBuilder: (i, item) {
                      var obj = RentVehiclesDoc.fromDocument(item);
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: MyPostListTile(
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!,
                          text: "Rs. "+obj.rentAmount.toInt().toString() + " " + ToolDurationTypes.data[obj.rentDurationType]!,
                          imageUrl: obj.imageUrls[0]??null,
                          onEditTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => RentVehiclePage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              rentVehiclesKey.currentState!.refreshList();
                            }
                          },
                          secondButtonLabel: obj.isAvailable ? "Make Unavailable" : "Make Available",
                          onSecondButtonTap: () async {
                            bool confirm = await Dialogs.showConfirmationDialog(
                              context: context, 
                              title: "Make ${obj.isAvailable?'unavailable':'available'}?", 
                              subtitle: "Are you sure you want to make this item ${obj.isAvailable?'unavailable':'available'}?",
                            );
                            print(confirm);
                            if(confirm) {
                              bool updated = await changeAvailiblilty(obj);
                              if(updated) rentVehiclesKey.currentState!.refreshList();
                            }
                          },
                        ),
                      );
                    }
                  ),
                  PostList(
                    key: rentWarehousesKey,
                    query: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("RentWarehouses")
                      .collection("Entries")
                      .where(BaseDoc.UID, isEqualTo: globalUser!.uid), 
                    itemBuilder: (i, item) {
                      var obj = RentWarehousesDoc.fromDocument(item);
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: MyPostListTile(
                          title: obj.title*20,
                          subtitle: toolsCategories[obj.category]!, 
                          text: "Rs. "+obj.rentAmount.toInt().toString() + " " + WarehouseDurationTypes.data[obj.rentDurationType]!,
                          imageUrl: obj.imageUrls[0]??null,
                          onEditTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => RentWarehousePage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              rentWarehousesKey.currentState!.refreshList();
                            }
                          },
                          secondButtonLabel: obj.isAvailable ? "Make Unavailable" : "Make Available",
                          onSecondButtonTap: () async {
                            bool confirm = await Dialogs.showConfirmationDialog(
                              context: context, 
                              title: "Make ${obj.isAvailable?'unavailable':'available'}?", 
                              subtitle: "Are you sure you want to make this item ${obj.isAvailable?'unavailable':'available'}?",
                            );
                            print(confirm);
                            if(confirm) {
                              bool updated = await changeAvailiblilty(obj);
                              if(updated) rentWarehousesKey.currentState!.refreshList();
                            }
                          },
                        ),
                      );
                    }
                  ),
                  PostList(
                    key: sellToolsKey,
                    query: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("SellTools")
                      .collection("Entries")
                      .where(BaseDoc.UID, isEqualTo: globalUser!.uid), 
                    itemBuilder: (i, item) {
                      var obj = SellToolsDoc.fromDocument(item);
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: MyPostListTile(
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!,
                          text: "Rs. "+obj.sellAmount.toInt().toString(),
                          imageUrl: obj.imageUrls[0]??null,
                          onEditTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => SellToolPage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              sellToolsKey.currentState!.refreshList();
                            }
                          },
                          secondButtonLabel: obj.isAvailable ? "Make Unavailable" : "Make Available",
                          onSecondButtonTap: () async {
                            bool confirm = await Dialogs.showConfirmationDialog(
                              context: context, 
                              title: "Make ${obj.isAvailable?'unavailable':'available'}?", 
                              subtitle: "Are you sure you want to make this item ${obj.isAvailable?'unavailable':'available'}?",
                            );
                            print(confirm);
                            if(confirm) {
                              bool updated = await changeAvailiblilty(obj);
                              if(updated) sellToolsKey.currentState!.refreshList();
                            }
                          },
                        ),
                      );
                    },
                  ),
                  PostList(
                    key: sellVehiclesKey,
                    query: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("SellVehicles")
                      .collection("Entries")
                      .where(BaseDoc.UID, isEqualTo: globalUser!.uid), 
                    itemBuilder: (i, item) {
                      var obj = SellVehiclesDoc.fromDocument(item);
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: MyPostListTile(
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!,
                          text: "Rs. "+obj.sellAmount.toInt().toString(),
                          imageUrl: obj.imageUrls[0]??null,
                          onEditTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => SellVehiclePage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              sellVehiclesKey.currentState!.refreshList();
                            }
                          },
                          secondButtonLabel: obj.isAvailable ? "Make Unavailable" : "Make Available",
                          onSecondButtonTap: () async {
                            bool confirm = await Dialogs.showConfirmationDialog(
                              context: context, 
                              title: "Make ${obj.isAvailable?'unavailable':'available'}?", 
                              subtitle: "Are you sure you want to make this item ${obj.isAvailable?'unavailable':'available'}?",
                            );
                            print(confirm);
                            if(confirm) {
                              bool updated = await changeAvailiblilty(obj);
                              if(updated) sellVehiclesKey.currentState!.refreshList();
                            }
                          },
                        ),
                      );
                    }
                  ),
                  PostList(
                    key: laborsKey,
                    query: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc("Labors")
                      .collection("Entries")
                      .where(BaseDoc.UID, isEqualTo: globalUser!.uid), 
                    itemBuilder: (i, item) {
                      var obj = LaborsDoc.fromDocument(item);
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: MyPostListTile(
                          title: obj.title*20,
                          subtitle: laborsCategories[obj.category]!, 
                          text: "Rs. "+obj.wageAmount.toInt().toString() + " " + LaborDurationTypes.data[obj.wageDurationType]!,
                          imageUrl: null,
                          onEditTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => AddLaborPage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              laborsKey.currentState!.refreshList();
                            }
                          },
                          secondButtonLabel: obj.isAvailable ? "Make Unavailable" : "Make Available",
                          onSecondButtonTap: () async {
                            bool confirm = await Dialogs.showConfirmationDialog(
                              context: context, 
                              title: "Make ${obj.isAvailable?'unavailable':'available'}?", 
                              subtitle: "Are you sure you want to make this item ${obj.isAvailable?'unavailable':'available'}?",
                            );
                            print(confirm);
                            if(confirm) {
                              bool updated = await changeAvailiblilty(obj);
                              if(updated) laborsKey.currentState!.refreshList();
                            }
                          },
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }


  Future<bool> changeAvailiblilty(BaseDoc doc) async {
    try {
      await doc.firebaseDocRef.update({
        BaseDoc.ISAVAILABLE : !doc.isAvailable,
        BaseDoc.UPDATEDTIMESTAMP : FieldValue.serverTimestamp(),
      });
      return Future.value(true);
    } on Exception {
      return Future.value(false);
    }
  }

}