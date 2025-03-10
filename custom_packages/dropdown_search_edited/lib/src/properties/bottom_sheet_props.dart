import 'package:flutter/material.dart';

class BottomSheetProps {
  final List<Widget>? actions;
  final MainAxisAlignment? actionsAlignment;
  final OverflowBarAlignment? actionsOverflowAlignment;
  final double? actionsOverflowButtonSpacing;
  final VerticalDirection? actionsOverflowDirection;
  final EdgeInsetsGeometry actionsPadding;
  final EdgeInsets insetPadding;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry contentPadding;
  final Offset? anchorPoint;
  final RouteTransitionsBuilder? transitionBuilder;
  final ShapeBorder? shape;
  final bool useRootNavigator;
  final BoxConstraints constraints;
  final double? elevation;
  final String? semanticLabel;
  final Color? barrierColor;
  final String barrierLabel;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Duration transitionDuration;
  final Clip clipBehavior;
  final AnimationController? animation;
  final TextStyle? contentTextStyle;
  final bool enableDrag;

  const BottomSheetProps({
    this.contentTextStyle,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.barrierColor,
    this.barrierLabel = '',
    this.backgroundColor,
    this.barrierDismissible = true,
    this.transitionDuration = kThemeChangeDuration,
    this.animation,
    this.actions,
    this.enableDrag = true,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowButtonSpacing,
    this.actionsOverflowDirection,
    this.clipBehavior = Clip.none,
    this.useRootNavigator = false,
    this.constraints = const BoxConstraints(maxHeight: 500),
    this.actionsPadding = EdgeInsets.zero,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 24.0,
    ),
    this.buttonPadding,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.anchorPoint,
    this.transitionBuilder,
  });
}
