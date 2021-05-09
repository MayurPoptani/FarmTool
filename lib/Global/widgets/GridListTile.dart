import 'package:farmtool/Global/functions/ExtendedImageFunctions.dart';
import 'package:flutter/material.dart';
import 'MyExtentions.dart';

class GridListTile extends StatefulWidget {

  static double get GRIDCROSSRATIO => 0.75;

  final String header;
  final String? textOnTop;
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isFavourite;
  final void Function()? onTap;

  const GridListTile({
    Key? key, 
    this.textOnTop,
    required this.header, 
    required this.title, 
    required this.subtitle, 
    required this.imageUrl, 
    this.onTap,
    this.isFavourite = false,
  }) : super(key: key);

  @override
  _GridListTileState createState() => _GridListTileState();
}

class _GridListTileState extends State<GridListTile> {
 bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      shadowColor: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // color: Colors.green.shade400.withOpacity(1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8,),
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    Card(
                      elevation: 16,
                      shadowColor: Colors.black54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Container(
                          child: ExtendedImage.network(widget.imageUrl,
                            height: MediaQuery.of(context).size.width*.375,
                            fit: BoxFit.fill,
                            timeLimit: Duration(seconds: 5),
                            loadStateChanged: extendedImageStateBuilder,
                          ),
                        ),
                      ),
                    ),
                    if(widget.textOnTop!=null) Positioned(
                      top: 8, right: 8,
                      child: Container(
                        child: Text(widget.textOnTop!, 
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 0, 
                              color: Colors.white60
                            )
                          ]
                        ),
                      ),
                    ),
                    Positioned(
                      // top: 8, right: 8,
                      bottom: 8,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: context.deviceSize.width*.3),
                          child: Text(widget.header, 
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ).marquee(),
                          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 0, 
                                color: Colors.white60
                              )
                            ]
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.title, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)).marquee(),
                          Text(widget.subtitle, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54,)).marquee(),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(4.0).copyWith(top: 6),
                      child: Icon(!favourite ? Icons.favorite_border_rounded : Icons.favorite_rounded, 
                        color: Colors.red,  
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => setState(() => favourite=!favourite),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}