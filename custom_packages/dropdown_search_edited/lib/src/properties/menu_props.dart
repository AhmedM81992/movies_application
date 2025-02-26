import 'package:flutter/material.dart';

import '../../dropdown_search_edited.dart';

class MenuProps {
  final ShapeBorder? shape;
  final BoxConstraints constraints;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final AnimationController? animation;
  final BorderRadiusGeometry? borderRadius;
  final Duration animationDuration;
  final Color? shadowColor;
  final TextStyle? textStyle;
  final bool borderOnForeground;
  final Curve? barrierCurve;
  final String? barrierLabel;
  final PositionCallback? positionCallback;

  const MenuProps({
    this.barrierLabel,
    this.barrierCurve,
    this.elevation,
    this.shape,
    this.positionCallback,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.animation,
    this.clipBehavior = Clip.none,
    this.constraints = const BoxConstraints(maxHeight: 350),
    this.animationDuration = const Duration(milliseconds: 300),
    this.textStyle,
    this.borderOnForeground = false,
    this.borderRadius,
    this.shadowColor,
  });
}
