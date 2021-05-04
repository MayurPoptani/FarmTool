import 'package:farmtool/Global/widgets/Marquee.dart';
import 'package:flutter/widgets.dart';

extension ContainerBasedExtentions on Widget {
  Widget marquee([
    Duration pauseDuration = const Duration(milliseconds: 800),
    Duration animationDuration = const Duration(milliseconds: 3000),
    Duration backDuration = const Duration(milliseconds: 800),
  ]) => Marquee(child: this, animationDuration: animationDuration, backDuration: backDuration, pauseDuration: pauseDuration,);
}

