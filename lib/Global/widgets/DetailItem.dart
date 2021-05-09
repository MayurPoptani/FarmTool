import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;
  const DetailItem({
    Key? key, 
    required this.icon, 
    required this.label, 
    required this.text
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Icon(icon, color: Colors.white,),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green,
            ),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.black54, fontSize: 14),),
                Text(text, style: TextStyle(color: Colors.black, fontSize: 16),),
              ],
            ),
          )
        ],
      ),
    );
  }
}