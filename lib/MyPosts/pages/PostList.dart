import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtool/Global/widgets/GridListTile.dart';
import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  final Query query;
  final Widget Function(int, DocumentSnapshot) itemBuilder;
  
  const PostList({Key? key, required this.query, required this.itemBuilder}) : super(key: key);
  
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<QuerySnapshot>(
      future: widget.query.get(),
      initialData: null,
      builder: (_, snap) {
        print(snap.connectionState);
        if(snap.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green.shade700),),);
        else if(snap.connectionState==ConnectionState.done && snap.hasData) return Container(
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
                    itemCount: snap.data!.docs.length,
                    itemBuilder: (_, i) {
                      return widget.itemBuilder(i, snap.data!.docs[i]);
                    }
                  ),
                ),
              ),
            ],
          ),
        );
        return Container();
      },
    );
  }

  @override bool get wantKeepAlive => true;
}