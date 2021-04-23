import 'package:farmtool/Global/classes/ToolsDoc.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/RentTools/RentToolDetailsPage.dart';
import 'package:flutter/material.dart';

class RentToolListItem extends StatelessWidget {

  final ToolsDoc item;
  RentToolListItem(this.item);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => RentToolDetailsPage(item)));
        },
        child: Hero(
          tag: item.id,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network("https://www.easydigging.com/images-new/home-garden-spade.jpg",
                      width: MediaQuery.of(context).size.width*.15,
                      height: MediaQuery.of(context).size.width*.15,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                        SizedBox(height: 4,),
                        Text(item.desc, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),),
                        SizedBox(height: 4,),
                        Row(children: [
                          Expanded(child: Text("Rs. "+item.rentAmount.toString()+"/hr", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),)),
                          Container(
                            height: 18,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 0.5,
                            ),
                          ),
                          Expanded(child: Text(item.category, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),)),
                        ],)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}