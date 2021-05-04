import 'package:farmtool/Global/functions/ExtendedImageFunctions.dart';
import 'package:farmtool/Global/widgets/Marquee.dart';
import 'package:flutter/material.dart';
import 'ContainerBasedExtentions.dart';
import 'package:extended_image/extended_image.dart';

class MyPostListTile extends StatefulWidget {

  final String title;
  final String subtitle;
  final String text;
  final String imageUrl;
  final void Function()? onEditTap;
  final String? secondButtonLabel;
  final void Function()? onSecondButtonTap;

  const MyPostListTile({
    Key? key, 
    required this.title, 
    required this.subtitle, 
    required this.text, 
    required this.imageUrl, 
    required this.onEditTap,
    this.secondButtonLabel,
    this.onSecondButtonTap,
  }) : super(key: key);

  @override
  _MyPostListTileState createState() => _MyPostListTileState();
}

class _MyPostListTileState extends State<MyPostListTile> {
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
          onTap: widget.onEditTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width*.2,
                    width: MediaQuery.of(context).size.width*.2,
                    child: Card(
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
                          child: ExtendedImage.network(
                            widget.imageUrl,
                            height: MediaQuery.of(context).size.width*.375,
                            fit: BoxFit.fill,
                            cache: true,
                            timeLimit: Duration(seconds: 5),
                            loadStateChanged: extendedImageStateBuilder,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 0,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.title, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)).marquee(),
                          Text(widget.subtitle, softWrap: true, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54,)).marquee(),
                          Text(widget.text, softWrap: true, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black,)).marquee(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  ElevatedButton(
                    child: Container(padding: EdgeInsets.all(12), child: Text("Edit Entry", style: TextStyle(color: Colors.white),)),
                    onPressed: widget.onEditTap,
                  ),
                  if(widget.secondButtonLabel!=null) SizedBox(width: 8,),
                  if(widget.secondButtonLabel!=null) Expanded(
                    child: ElevatedButton(
                      child: Container(padding: EdgeInsets.all(12), child: Text(widget.secondButtonLabel!, style: TextStyle(color: Colors.white),)),
                      onPressed: widget.onSecondButtonTap,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(widget.onSecondButtonTap==null ? Colors.grey : null),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}