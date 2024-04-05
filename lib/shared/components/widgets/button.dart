
import 'package:flutter/material.dart';
import '../../styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = mainColor,
  bool isUpperCase = true,
  double radius = 10,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: mainColor,
      ),
      child: IconButton(
        onPressed: () {
          function();
        },
        icon: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );