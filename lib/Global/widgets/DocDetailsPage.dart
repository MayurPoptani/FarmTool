import 'package:farmtool/Global/classes/BaseDoc.dart';
import 'package:farmtool/Global/functions/ExtendedImageFunctions.dart';
import 'package:farmtool/Global/widgets/DetailItem.dart';
import 'package:flutter/material.dart';
import 'package:farmtool/Global/widgets/MyExtentions.dart';

class DocDetailsPage extends StatefulWidget {
  final String docId;
  final String title;
  final List<DetailItem> detailItems;
  final String buttonLabel;
  final List<dynamic>? imageUrls;
  final void Function() onButtonTap;

  const DocDetailsPage({
    Key? key, 
    required this.docId, 
    required this.title, 
    required this.imageUrls,
    required this.detailItems, 
    required this.buttonLabel, 
    required this.onButtonTap
  }) : super(key: key);

  @override
  _DocDetailsPageState createState() => _DocDetailsPageState();
}

class _DocDetailsPageState extends State<DocDetailsPage> {
  
  bool favourite = false;
  int imgIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.docId,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: context.deviceSize.height*.55,
                          padding: EdgeInsets.all(16),
                          width: double.maxFinite,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Card(
                                elevation: 16,
                                shadowColor: Colors.black54,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16), topRight: Radius.circular(16)
                                            ),
                                            child: widget.imageUrls==null || widget.imageUrls!.length==0
                                            ? ExtendedImage.asset(
                                              "assets/images/farmer_image.png", 
                                              fit: BoxFit.fill, 
                                              width: double.maxFinite,
                                              loadStateChanged: extendedImageStateBuilder,
                                            ) : PageView.builder(
                                              itemCount: widget.imageUrls!.length,
                                              onPageChanged: (i) => setState(() => imgIndex = i),
                                              itemBuilder: (_, i) {
                                                return ExtendedImage.network(
                                                  widget.imageUrls![i].toString(), 
                                                  fit: BoxFit.fill, 
                                                  width: double.maxFinite,
                                                  loadStateChanged: extendedImageStateBuilder,
                                                );
                                              },
                                            )
                                          ),
                                          if(widget.imageUrls!=null && (widget.imageUrls!.length)>0) Positioned(
                                            bottom: 8,
                                            child: Card(
                                              elevation: 8,
                                              shadowColor: Colors.black54,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4,),
                                                child: Row(
                                                  children: List.generate(widget.imageUrls!.length, (index) => Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                    height: 8, width: 8,
                                                    decoration: BoxDecoration(
                                                      color: imgIndex == index ? Colors.green.shade900 : Colors.black45,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ),
                                    Container(
                                      height: 56,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                    ),
                                  ],
                                )
                              ),
                              Positioned(
                                top: 16, right: 16,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white60,
                                          spreadRadius: 6,
                                        )
                                      ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(favourite ? Icons.favorite_border_rounded : Icons.favorite_rounded, 
                                        color: Colors.red,  
                                      ),
                                    ),
                                  ),
                                  onTap: () => setState(() => favourite=!favourite),
                                ),
                              ),
                              Positioned(
                                top: 16, left: 16,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white60,
                                          spreadRadius: 6,
                                        )
                                      ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(Icons.arrow_back_rounded, color: Colors.red,),
                                    ),
                                  ),
                                  onTap: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24,),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.detailItems.length,
                            itemBuilder: (_, i) => widget.detailItems[i],
                            separatorBuilder: (context, index) => 16.heightbox,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(widget.buttonLabel, style: TextStyle(fontSize: 18),),
                          ),
                          onPressed: widget.onButtonTap, 
                        ),
                      ),
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
}