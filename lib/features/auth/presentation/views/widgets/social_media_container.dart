import 'package:flutter/material.dart';

class SocialMediaContainer extends StatelessWidget {
  const SocialMediaContainer({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      child: Icon(icon),
    );
  }
}
