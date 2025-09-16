import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
