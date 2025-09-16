import 'package:flutter/material.dart';

class CheckBoxSection extends StatefulWidget {
  const CheckBoxSection({super.key});

  @override
  State<CheckBoxSection> createState() => _CheckBoxSectionState();
}

class _CheckBoxSectionState extends State<CheckBoxSection> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.blue,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              isSelected = value!;
            });
          },
        ),
        Text('Remember me'),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
