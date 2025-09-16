import 'package:flutter/material.dart';

class ProfileContainerItem extends StatelessWidget {
  const ProfileContainerItem({
    super.key,
    required this.iconData,
    required this.title,
  });
  final IconData iconData;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Row(
        spacing: 10,
        children: [
          Icon(iconData, color: Colors.grey),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
