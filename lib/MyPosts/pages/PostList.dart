import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/widgets/GridListTile.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  final Query query;
  final Widget Function(int, DocumentSnapshot) itemBuilder;
  
  const PostList({Key? key, required this.query, required this.itemBuilder}) : super(key: key);
  
  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostList> with AutomaticKeepAliveClientMixin {

  QuerySnapshot? snap;
  ConnectionState state = ConnectionState.waiting;

  @override
  void initState() {
    refreshList();
    super.initState();
  }

  refreshList() {
    print(widget.query.parameters);
    widget.query.get().then((value) {
      snap = value;
      state = ConnectionState.done;
      if(mounted) setState(() {});
    }).onError((error, stackTrace) {
      state = ConnectionState.done;
      if(mounted) setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(state);
    if(state==ConnectionState.waiting) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green.shade700),),);
    else if(state==ConnectionState.done && snap!=null) return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: GridListTile.GRIDCROSSRATIO,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snap!.docs.length,
                itemBuilder: (_, i) {
                  return widget.itemBuilder(i, snap!.docs[i]);
                }
              ),
            ),
          ),
        ],
      ),
    );
    return Container();
  }

  @override bool get wantKeepAlive => true;
}