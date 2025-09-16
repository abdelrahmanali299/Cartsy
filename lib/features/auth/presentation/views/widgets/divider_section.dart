import 'package:flutter/material.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'or continue with',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
