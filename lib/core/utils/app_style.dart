import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/size_config.dart';

import 'app_colors.dart';

abstract class AppStyle {
  static TextStyle styleProductSansWhite25(context) {
    return TextStyle(
      color: AppColors.white,
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.bold,
    );
  }

  // static const TextStyle styleProductSansMediumBlack14 = TextStyle(
  //   color: AppColors.black,
  //   fontSize: getResponsiveFontSize(fontSize: 14),
  //   fontFamily: 'Product Sans Medium',
  //   fontWeight: FontWeight.w400,
  // );
  /// without context

  static TextStyle styleProductSansMediumBlack14(context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Product Sans Medium',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleProductSansWhite16(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Product Sans',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleProductSansBoldBlack16(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'PTSans',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleProductSansBoldGrey16(BuildContext context) {
    return TextStyle(
      color: AppColors.categoryColor,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'PTSansns',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle styleProductSansMediumBlack12(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'PTSans',
      fontWeight: FontWeight.w400,
    );
  }
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);

  /// Gets fontSize then makes it responsive.
}

double getScaleFactor(context) {
  double width = MediaQuery.sizeOf(context).width;

  if (width < SizeConfig.tablet) {
    return width / 1000;
  } else {
    return width / 1920;
  }

  //Gets the device width and returns a scale factor based on the device width.
  ///NOTE: This function doesnt update the screen after first build!!
}

// double getScaleFactor() {
//   var dispatcher = PlatformDispatcher.instance;
//   var phycicalWidth = dispatcher.views.first.physicalSize.width;
//   var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
//   double width = phycicalWidth / devicePixelRatio;

//   if (width < SizeConfig.tablet) {
//     return width / 1000;
//   } else {
//     return width / 1920;
//   }

//   //Gets the device width and returns a scale factor based on the device width.
//   //We use this function if we want to avoid using context.
//   ///NOTE: This function doesnt update the screen after first build!!
// }
