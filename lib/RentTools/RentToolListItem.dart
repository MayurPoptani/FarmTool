import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/RentTools/RentToolDetailsPage.dart';
import 'package:flutter/material.dart';

class RentToolListItem extends StatelessWidget {

  final RentToolsDoc item;
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
            color: colorBgColor.withOpacity(0.65),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(item.imageUrls.first,
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
                        Text(item.title, 
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),
                        ),
                        SizedBox(height: 4,), 
                        Text("Rs. "+item.rentAmount.toString()+" "+DurationTypes.data[item.rentDurationType]!, 
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400,),
                        ),
                        SizedBox(height: 4,),
                        Text(item.categoryName, 
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400,),
                        ),
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