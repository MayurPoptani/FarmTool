import 'package:flutter/widgets.dart';

extension ContextBasedExtentions on BuildContext {
  Size get deviceSize => MediaQuery.of(this).size;
}