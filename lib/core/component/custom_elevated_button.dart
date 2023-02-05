import 'package:flutter/material.dart';
import 'custom_text.dart';

Widget customElevatedButton({
  required String text,
  required Function() onPressed,
  Color? backgroundColor = Colors.green,
  Color? textColor = Colors.white,
  double width = double.infinity,
  double height = 45,
  double radius = 8,
  double fontSize = 20,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          animationDuration: const Duration(milliseconds: 5000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: backgroundColor,
          maximumSize: const Size(360, 50),
        ),
        onPressed: onPressed,
        child: customText(
          fontWeight: FontWeight.bold,
          text: text,
          fontSize: fontSize,
          color: textColor!,
        ),
      ),
    );
