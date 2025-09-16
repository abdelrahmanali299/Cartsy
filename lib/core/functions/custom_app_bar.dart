import 'package:flutter/material.dart';

AppBar customAppBar(
  BuildContext context, {
  required String title,
  bool isLeading = false,
}) => AppBar(
  title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
  centerTitle: true,
  leading: isLeading
      ? GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: Icon(Icons.arrow_back_ios_new),
          ),
        )
      : null,
  automaticallyImplyLeading: false,
);
