import 'package:flutter/material.dart';
import 'package:news/constants.dart';

class Screen {
  final BuildContext context;
  Screen(this.context);

  Size get size => MediaQuery.of(context).size;
  double get width => size.width;
  double get height => size.height;
  double get customWidth => width / realmeWidth;
  bool get isMobile => customWidth <= 0.4;
  bool get isTablet => !isMobile && width < 1000;
  bool get isDesktop => !isMobile && !isTablet;
}
