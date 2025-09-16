import 'package:flutter/material.dart';

class DiscountTextField extends StatelessWidget {
  const DiscountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),

        hintText: 'Enter Discount Code',
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: TextButton(
          onPressed: () {},
          child: Text('Apply', style: TextStyle(color: Colors.blue)),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.grey.withValues(alpha: .5),
        width: 1.5,
      ),
    );
  }
}
