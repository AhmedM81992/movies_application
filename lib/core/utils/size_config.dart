import 'package:flutter/material.dart';

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 600;

  static late double width, height;

  static init(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;

    ///Note: It won't Rebuild UI after first build!!
  }

  static SizedBox verticalSpace(double height) => SizedBox(
      height:
          height); // BRAIN_EXCEPTION: these ARE the SizeConfig helper methods themselves
  static SizedBox horizontalSpace(double width) => SizedBox(
      width:
          width); // BRAIN_EXCEPTION: these ARE the SizeConfig helper methods themselves
}
