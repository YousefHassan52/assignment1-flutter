

import 'package:flutter/material.dart';
ScaffoldFeatureController<SnackBar, SnackBarClosedReason>warningText({
  required context,
  required String text,
  required Color color,
}){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color,
    ),
  );
}