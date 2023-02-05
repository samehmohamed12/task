import 'package:flutter/material.dart';

Widget customText({
  required String text,
  TextOverflow? overflow,
  TextDecoration? textDecoration,
  Color color = Colors.black,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w400,
  int? maxLines,
}) =>
    Text(text,
        maxLines: maxLines,
        style: TextStyle(
          overflow: overflow,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration,
        ));
