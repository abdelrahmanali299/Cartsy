import 'package:flutter/material.dart';

class AddMinusCircle extends StatelessWidget {
  const AddMinusCircle({super.key, required this.icon});
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: icon,
    );
  }
}
