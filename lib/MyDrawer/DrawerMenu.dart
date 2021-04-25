import 'package:farmtool/MyDrawer/DrawerMenuItem.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  final int selectedIndex;
  final List<DrawerMenuItem> items;
  final Function(int) onChange;

  static _DrawerMenuState? of(BuildContext context) => context.findAncestorStateOfType<_DrawerMenuState>();

  const DrawerMenu({Key? key, required this.selectedIndex, required this.items, required this.onChange}) : super(key: key);
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (_, i) {
        widget.items[i].setIndex(i);
        return widget.items[i];
      }
    );
  }

  void changeIndex(int i) {
    selectedIndex = i;
    widget.onChange(selectedIndex);
    setState(() {});
  }
}