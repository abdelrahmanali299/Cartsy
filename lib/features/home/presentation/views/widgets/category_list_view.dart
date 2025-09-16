import 'package:fake_store/features/home/presentation/views/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key, required this.onCategoryChanged});
  final ValueChanged<String> onCategoryChanged;
  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  Map<String, Map<String, dynamic>> categories = {
    "all products": {
      "category name": "All",
      "category icon": 'assets/images/all_category_img.png',
    },
    "men's clothing": {
      "category name": "men's clothing",
      "category icon": 'assets/images/mens_clothing_img.png',
    },
    "jewelery": {
      "category name": "jewelery",
      "category icon": 'assets/images/jelewery.png',
    },
    "electronics": {
      "category name": "electronics",
      "category icon": 'assets/images/electronics_img.png',
    },
    "women's clothing": {
      "category name": "women's clothing",
      "category icon": 'assets/images/womens_clothing_img.png',
    },
  };
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.onCategoryChanged(
                  categories[categories.keys.toList()[index]]!["category name"],
                );
                currentIndex = index;
              });
            },
            child: CategoryItem(
              categoryTitle:
                  categories[categories.keys.toList()[index]]!["category name"],
              categoryImg:
                  categories[categories.keys.toList()[index]]!["category icon"],

              isSelected: currentIndex == index,
            ),
          ),
        );
      },
      itemCount: categories.keys.toList().length,
    );
  }
}
