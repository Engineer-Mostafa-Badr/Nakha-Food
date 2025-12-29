import 'package:flutter/material.dart';
import '../../utils/app_const.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final String? fontFamily;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double? letterSpacing;
  final double? height;
  final TextDirection? textDirection;
  final TextDecoration? decoration;
  final bool softWrap;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.maxLines,
    this.fontFamily,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.letterSpacing,
    this.height,
    this.textDirection,
    this.decoration,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily ?? AppConst.fontName(context),
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
      ),
    );
  }
}
