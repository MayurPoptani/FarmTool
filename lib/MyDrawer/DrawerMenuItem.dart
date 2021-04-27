import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/MyDrawer/DrawerMenu.dart';
import 'package:farmtool/MyDrawer/DrawerSubMenuItem.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatefulWidget {
  int index = -1;
  final IconData icon;
  final String title;
  final String subTitle;
  final List<DrawerSubMenuItem>? subMenuItems;
  final Function()? onTap;

  void setIndex(int i) => index = i;

  DrawerMenuItem({Key? key, required this.icon, required this.title, required this.subTitle, this.subMenuItems, this.onTap}) : super(key: key);

  @override
  _DrawerMenuItemState createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<DrawerMenuItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.onTap!=null) widget.onTap!();
        if(DrawerMenu.of(context)!.selectedIndex==widget.index) DrawerMenu.of(context)!.changeIndex(-1);
        else DrawerMenu.of(context)!.changeIndex(widget.index);
        Future.delayed(Duration(milliseconds: 10), () {
          if(mounted) setState(() {});
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Color(0xFFe44d20),
              ),
              width: double.maxFinite,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(widget.icon, size: 24, color: Colors.black,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.green.withOpacity(0.25),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,),),
                        SizedBox(height: 4,),
                        Row(children: [
                          Expanded(child: Text(widget.subTitle, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w100,),)),
                        ],),
                      ],
                    ),
                  ),
                ],
              ),  
            ),
          ),
          if(widget.subMenuItems!=null && widget.subMenuItems!.length>0) AnimatedCrossFade(
            crossFadeState: (DrawerMenu.of(context)!.selectedIndex==-1 || DrawerMenu.of(context)!.selectedIndex!=widget.index) ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            duration: Duration(milliseconds: 250,),
            firstChild: Container(), 
            secondChild: Container(
              margin: EdgeInsets.only(top: 4),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 4, right: 4,),
                itemCount: widget.subMenuItems!.length,
                itemBuilder: (_, i) => widget.subMenuItems![i],
              ),
            ), 
          ),
        ],
      ),
    );
  }
}