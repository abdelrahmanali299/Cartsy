import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.buttonColor,
  });
  final void Function()? onPressed;
  final dynamic title;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(buttonColor ?? Colors.blue),
        fixedSize: WidgetStatePropertyAll(
          Size(double.maxFinite, MediaQuery.sizeOf(context).height * 0.08),
        ),
      ),
      onPressed: onPressed,
      child: title is Widget
          ? title
          : Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
    );
  }
}
