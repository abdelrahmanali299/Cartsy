import 'package:fake_store/features/home/presentation/views/widgets/bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          BottomNavigationItem(icon: Icons.home, title: 'Home'),
          BottomNavigationItem(icon: Icons.home, title: 'Home'),
          BottomNavigationItem(icon: Icons.home, title: 'Home'),
          BottomNavigationItem(icon: Icons.home, title: 'Home'),
        ],
      ),
    );
  }
}
