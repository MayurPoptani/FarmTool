import 'package:flutter/material.dart';

class TextFomFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFomFieldContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.white,
        color: Colors.black.withOpacity(0.1),
        boxShadow: [BoxShadow(color: Colors.white30, blurRadius: 8, offset: Offset(-2, 2),),],
      ),
      child: child,
    );
  }
}