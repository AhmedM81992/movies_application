import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  factory AppText.headline(String text, {Color? color}) => AppText(
        text,
        style: _headlineStyle.copyWith(color: color),
      );

  factory AppText.body(String text, {Color? color}) => AppText(
        text,
        style: _bodyStyle.copyWith(color: color),
      );

  factory AppText.caption(String text, {Color? color}) => AppText(
        text,
        style: _captionStyle.copyWith(color: color),
      );

  static const TextStyle _headlineStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Product Sans',
  );

  static const TextStyle _bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Product Sans',
  );

  static const TextStyle _captionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Product Sans',
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? _bodyStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
