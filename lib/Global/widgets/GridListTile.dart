import 'package:flutter/material.dart';

class GridListTile extends StatefulWidget {

  final String header;
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isFavourite;
  final void Function()? onTap;

  const GridListTile({
    Key? key, 
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
                          child: Image.network(widget.imageUrl,
                            height: MediaQuery.of(context).size.width*.375,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        child: Text(widget.header, 
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 4, 
                              color: Colors.white60
                            )
                          ]
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
                          Text(widget.title, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                          Text(widget.subtitle, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54,)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(4.0).copyWith(top: 6),
                      child: Icon(favourite ? Icons.favorite_border_rounded : Icons.favorite_rounded, 
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