import 'package:flutter/material.dart';

customSnackBar(BuildContext context, String message, Color backgroundColor) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Center(child: Text(message)),
      backgroundColor: backgroundColor,
      duration: Duration(milliseconds: 700),
    ),
  );
}
