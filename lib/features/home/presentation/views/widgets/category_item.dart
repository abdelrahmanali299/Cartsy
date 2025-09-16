import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryTitle,
    this.isSelected = false,
    required this.categoryImg,
  });
  final String categoryTitle;
  final String categoryImg;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: FittedBox(
        child: Column(
          spacing: 5,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.cyanAccent : Colors.grey[300],
              ),
              child: Image.asset(categoryImg),
            ),
            FittedBox(child: Text(categoryTitle)),
          ],
        ),
      ),
    );
  }
}
