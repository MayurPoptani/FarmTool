import 'package:farmtool/Global/variables/Colors.dart';
import 'package:flutter/material.dart';

class DrawerSubMenuItem extends StatefulWidget {
  final String title;
  final Function() onTap;

  const DrawerSubMenuItem({Key? key, required this.title, required this.onTap}) : super(key: key);
  @override
  _DrawerSubMenuItemState createState() => _DrawerSubMenuItemState();
}

class _DrawerSubMenuItemState extends State<DrawerSubMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text("-", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  tileColor: colorBgColor.withOpacity(0.65),
                  title: Text(widget.title, style: TextStyle(color: Colors.white,),),
                  onTap: widget.onTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}