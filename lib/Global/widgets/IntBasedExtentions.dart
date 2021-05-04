import 'package:flutter/material.dart';

extension IntBasedExtentions on int {
  Widget get heightbox => SizedBox(height: this.toDouble(),);  
  Widget get widthbox => SizedBox(width: this.toDouble(),);  
}