import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/AddToolPost/RentToolPage/RentToolPage.dart';
import 'package:farmtool/AddToolPost/SellToolPage/SellToolPage.dart';
import 'package:farmtool/AddVehiclePost/RentVehiclePage/RentVehiclePage.dart';
import 'package:farmtool/AddVehiclePost/SellVehiclePage/SellVehiclePage.dart';
import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/SellToolsDoc.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/GridListTile.dart';
import 'package:farmtool/MyPosts/pages/PostList.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  GlobalKey<PostListState> rentToolsKey = GlobalKey();
  GlobalKey<PostListState> rentVehiclesKey = GlobalKey();
  GlobalKey<PostListState> sellToolsKey = GlobalKey();
  GlobalKey<PostListState> sellVehiclesKey = GlobalKey();
  

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
                Tab(child: Text("Selling Tools"),),
                Tab(child: Text("Selling Vehicles"),),
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
                        child: GridListTile(
                          header: "Rs. "+obj.rentAmount.toStringAsFixed(0), 
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!, 
                          imageUrl: obj.imageUrls[0]??null,
                          onTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => RentToolPage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              rentToolsKey.currentState!.refreshList();
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
                        child: GridListTile(
                          header: "Rs. "+obj.rentAmount.toStringAsFixed(0), 
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!, 
                          imageUrl: obj.imageUrls[0]??null,
                          onTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => RentVehiclePage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              rentVehiclesKey.currentState!.refreshList();
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
                        child: GridListTile(
                          header: "Rs. "+obj.sellAmount.toStringAsFixed(0), 
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!, 
                          imageUrl: obj.imageUrls[0]??null,
                          onTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => SellToolPage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              sellToolsKey.currentState!.refreshList();
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
                        child: GridListTile(
                          header: "Rs. "+obj.sellAmount.toStringAsFixed(0), 
                          title: obj.title, 
                          subtitle: toolsCategories[obj.category]!, 
                          imageUrl: obj.imageUrls[0]??null,
                          onTap: () async {
                            bool? shouldUpdate = await Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (_) => SellVehiclePage.edit(obj)));
                            print("shouldUpdate = "+shouldUpdate.toString());
                            if(shouldUpdate!=null && shouldUpdate) {
                              sellVehiclesKey.currentState!.refreshList();
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
}